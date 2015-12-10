---
title: Shells and the Remote Monad Design Pattern
layout: post
---

The **remote monad design pattern** is a way of encapsulating external
monadic capabilities.
The idea is that, rather than directly call a remote  or external procedure,
we instead give the external procedure call a service-specific monadic
type, and invoke the external procedure call using a monadic "send" function.
Specifically, a **remote monad** is a monad that has its evaluation function in
a remote location, outside the local runtime system.
This blog article, the first in a series, examines reflecting 
shell commands for accessing external data from Haskell.
We will look at the `PlistBuddy` OSX UNIX command, its
internal shell, and how to provide access to this shell for Haskell
users.

<!--MORE-->


### Plists and PlistBuddy

Plists are a format used in OSX and iOS for storing configuration data,
and are sometimes used as small, text-based databases.
They are, to a first approximation, XML-based representations of JSON-style records,
where each Plist is a single file with one, sometimes large, XML structure inside.
OSX and iOS applications use libraries for reading, modifying and writing Plists.

PlistBuddy is a UNIX command for modifying Plists. PlistBuddy has a interactive
mode, and it is this interactive mode we are interested in reflecting into Haskell.


    $ /usr/libexec/PlistBuddy  --help
    Command Format:
        Help - Prints this information
        Exit - Exits the program, changes are not saved to the file
        Save - Saves the current changes to the file
        Revert - Reloads the last saved version of the file
        Clear [<Type>] - Clears out all existing entries, and creates root of Type
        Print [<Entry>] - Prints value of Entry.  Otherwise, prints file
        Set <Entry> <Value> - Sets the value at Entry to Value
        Add <Entry> <Type> [<Value>] - Adds Entry to the plist, with value Value
        Delete <Entry> - Deletes Entry from the plist
    ...

To give an example, we can create a Plist, populate it, examine it, and save it.


    $ /usr/libexec/PlistBuddy example.plist
    File Doesn't Exist, Will Create: example.plist
    Command: add user string 'Fred Flintstone'
    Command: add age integer 39
    Command: print
    Dict {
        age = 39
        user = Fred Flintstone
    }
    Command: print age
    39
    Command: save
    Saving...
    Command: quit

The file `example.plist` is now 

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>age</key>
	<integer>39</integer>
	<key>user</key>
	<string>Fred Flintstone</string>
</dict>
</plist>
{% endhighlight %}

This is a trivial example; dictionaries and arrays can be nested to arbitrary depths.
`PlistBuddy` robustly looks after the reading and writing of the XML file.
Of course, we could write a `PlistBuddy`-clone in Haskell, but this misses the point:

 * `PlistBuddy` supports 2  additional file formats used by OSX & iOS, including a binary format.
 * `PlistBuddy` supports multi-megabyte plists out of the box.
 
By providing a useable API for Haskell users that uses `PlistBuddy` directly, we quickly can use
the capability in a robust way. If in the future, plist resources ends up on the critical path,
we can replace the library with a native Haskell library, or use the FFI to call a C library.

### The PlistBuddy Remote Monad

Remote monad calls are a generalization of remote procedure calls. The
calls do not need to be across a network; the "remote" in remote monad
designates externalization from the Haskell runtime system. In this case,
we are sending a text command to another UNIX process, and receiving text
back.

Our basic API consists of (1) an opener, to open a channel to the remote
resource; (2) the `send` command; and (3) the remote monadic commands,
which use a monad call `PlistBuddy`.

{% highlight Haskell %}
-- Our opener
openPlist :: FilePath -> IO Plist

-- Our 'send' command
send :: Plist -> PlistBuddy a -> IO a

-- Our remote monadic commands
help   ::                    PlistBuddy Text
exit   ::                    PlistBuddy ()
save   ::                    PlistBuddy ()
revert ::                    PlistBuddy ()
clear  :: Value           -> PlistBuddy ()
get    :: [Text]          -> PlistBuddy Value
set    :: [Text] -> Value -> PlistBuddy ()
add    :: [Text] -> Value -> PlistBuddy ()
delete :: [Text]          -> PlistBuddy ()

data Value  = String Text
            | Array [Value]       
            | Dict [(Text,Value)] 
            | Bool Bool
            | Real Double
            | Integer Integer
            | Date UTCTime
            | Data ByteString
{% endhighlight %}

The `openPlist` command opens a plist file by spawning off a PlistBuddy instance, 
using the [posix-pty](https://hackage.Haskell.org/package/posix-pty) package,
which creates a pseudo terminal for the UNIX process. The `send` command sends a monadic `PlistBuddy` 
command to a specific Plist. Finally, the commands are the primitives in
the remote monad called `PlistBuddy`. To repeat the earlier example:

{% highlight Haskell %}
GHCi> p <- openPlist "example.plist"
GHCi> send p $ do { add ["user"] (String "Fred Flintstone"); add ["age"] (Integer 39) }
GHCi> send p $ get []
Dict [("age",Integer 39),("user",String "Fred Flintstone")]
GHCi> send p $ get ["age"]
Integer 39
GHCi> send p $ do { save ; exit }
{% endhighlight %}

We can now programmatically build `PlistBuddy` monadic functions that manipulate
plists. Further, because we use a `send` function, we can manipulate many plists
at the same time.

### Implementing the PlistBuddy Remote Monad

We have [implemented](https://github.com/andygill/plist-buddy)
this design in the package
[plist-buddy](https://hackage.haskell.org/package/plist-buddy).
There are many ways of implementing a remote monad. In this case, 
`PlistBuddy` is our remote monad, constructed out of a reader monad for the type `Plist`,
and an exception monad for Plist-specific exceptions.

{% highlight Haskell %}
newtype PlistBuddy a = PlistBuddy (ExceptT PlistError (ReaderT Plist IO) a)
  deriving (Functor, Applicative, Monad, MonadError PlistError, MonadReader Plist, MonadIO)

newtype PlistError = PlistError String 
 deriving (Show, Eq)
{% endhighlight %}

The `openPlist` command spawns the /usr/libexec/PlistBuddy shell command, and returns the handles to this
process.

{% highlight Haskell %}
openPlist :: FilePath -> IO Plist
openPlist fileName = do
    (pty,ph) <- spawnWithPty
                    ...
                    "/usr/libexec/PlistBuddy"
                    ["-x",fileName]
                    ...
    ...
    return $ Plist pty ph ...
{% endhighlight %}


The `send` command sends the `PlistBuddy` to the plist by executing the inner monad,
using the standard monad transformer run functions. Slightly simplified, we have:

{% highlight Haskell %}
send :: Plist -> PlistBuddy a -> IO a
send dev (PlistBuddy m) = do
    v <- runReaderT (runExceptT m) dev
    case v of
      Left (PlistError msg) -> fail msg
      Right val -> return val
{% endhighlight %}

Finally, each `PlistBuddy` command calls the plist process using an internal utility function `command`.
To take an example, consider `delete`.

{% highlight Haskell %}
command :: Plist -> ByteString -> IO ByteString
command plist input = do
        writePty pty (input <> "\n")
        recvReply pty
    where
        pty = plist_pty plist

delete :: [Text] -> PlistBuddy ()
delete entry = do
        plist <- ask
        res <- liftIO $ command plist $ "delete " <>  BS.concat [ ":" <> quoteText e | e <- entry ]
        case res of
          "" -> return ()
          _  -> throwPlistError $ PlistError $ "delete failed: " ++ show res
{% endhighlight %}

`command` is our remote evaluator, which uses the external process shell; sending
commands, and receiving replies.
Each remote monad primitive, like `delete`, uses `command` to send a textual command to
the plist buddy sub-process, and waits for a reply, in this case the empty string.
We call this implementation a **weak remote monad**, because each remote monad primitive
directly invokes the remote service. There is a one-to-one correspondence between primitive and
remote invocation, and we make no attempt to bundle commands into packets or optimize
this communication.
To summarize, the `PlistBuddy` remote monad is a typed API around the `command` utility function
for talking to an external shell. The design pattern guided our external API, and helped us
structure our internal implementation.

In the next blog article, we will look at a *strong* remote monad, where we bundle
together many commands into a single packet, to amortize the cost of using a remote
service. For anyone that wants to know more, we also have a web page about the
[remote monad](/practice/remotemonad/), including a list
of existing applications that use the remote monad, and a link to our 
Haskell Symposium paper.


