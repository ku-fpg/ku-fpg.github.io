---
title: The Remote JSON library
layout: post
---

[JSON-RPC](http://www.jsonrpc.org/) is a simple and well supported protocol for
remote procedure calls over the HTTP. 
JSON-RPC supports both synchronous remote methods calls,
and asynchronous notifications. We want to access JSON-RPC from Haskell,
but in a principled way. This blog post discusses the design and implementation
of remote-json, a new library for JSON-RPC that makes use of the
[remote monad design pattern](/practice/remotemonad/)

To give an example from the specification, consider calling
a method `subtract`, with the arguments `42` and `23`.

{% highlight json %}
--> {"jsonrpc": "2.0", "method": "subtract", "params": [42, 23], "id": 1}
<-- {"jsonrpc": "2.0", "result": 19, "id": 1}
{% endhighlight %}

Here, `-->` is the data sent from client to server, and `<--` is what the
server responds. The packet being sent is a simple JSON object, as is the 
reply from the server.

The JSON-RPC protocol supports batching
(sending several method calls and notifications at the same time) and
is easy to debug, because it is straightforward to read JSON structures.
Furthermore, by using JSON-RPC we can implement our clients
in Haskell, and be agnostic about what language or framework the server is written in.

There are at least five existing Haskell libraries that support
JSON-RPC. So why a new library?
We wanted to build our own because we saw a 
way of simplifying the API considerably, while still allowing
access to all the capabilities of JSON-RPC. Specifically,
by using the remote monad design pattern
**we can automate taking advantage of the batch capability**,
amortizing the cost of the remote call. Rather than have
separate entry points for batched and singleton calls,
a single entry point can provide both batched and singleton calls,
simplifying the API.
The library also acts as a case study of using the remote monad.

## Basic Design of the JSON-RPC API

We center our design around the `RPC` monad.

{% highlight haskell %}
-- The monad
data RPC :: * -> * deriving (Monad, Applicative, Functor)

-- The primitives
method       :: Text -> Args -> RPC Value
notification :: Text -> Args -> RPC ()
  
-- the remote send
send         :: Session -> RPC a -> IO a
{% endhighlight %}

This is a classical remote monad design - a restricted monad, a small number of primitives
for this monad, and a `send` function. `Session` is an abstract handle to the web server
we want to talk to; we'll come back to how to generate a `Session` shortly.

This API gives an untyped access to JSON-RPC.
As an example, consider sending two `say` notifications, that make the remote
server say things, and a `temperature` method that returns the remote server's temperature.

{% highlight haskell %}
example :: Session -> IO ()
example s = do
  t <- send s $ do
          notification "say" (List [String "Hello, "])
          notification "say" (List [String "World!"])
          method "temperature" None
  print t
{% endhighlight %}
  
This is our basic capability, but a bit low-level for most Haskellers' tastes.
We can build a DSL that supports the same capabilities. Assuming our above
API is imported used `R`, we can write

{% highlight haskell %}
newtype DSL a = DSL (R.RPC a)
  deriving (Monad, Applicative, Functor)

method :: FromJSON a => Text -> [Value] -> DSL a
method nm args = (DSL . R.result) (R.method nm (R.List args))

notification :: Text -> [Value] -> DSL ()
notification nm = DSL . R.notification nm . R.List

temperature :: DSL Int
temperature = method "temperature" [] 
                       
say :: Text -> DSL ()
say msg = notification "say" [toJSON msg]

send :: Session -> DSL a -> IO a
send s (DSL m) = R.send s m
{% endhighlight %}

(Here `R.result` is a utility function that parses `Value` into a specific
type.)

Now we have a typed API for `temperature` and `say`, making our invocation much cleaner.

{% highlight haskell %}
example :: Session -> IO ()
example s = do
  t <- send s $ do
          say "Hello, "
          say "World!"
          temperature
  print t
{% endhighlight %}

`send` can be used
multiple times if needed, acting as translation between our `IO` monad, and the remote `RPC`/`DSL` monad.

Both examples will generate the same session interactions with the server, given 
the same `Session`. The above example produces the following JSON-RPC interaction with the server:

{% highlight json %}
--> {"jsonrpc": "2.0", "method": "say", "params": ["Hello, "]}
// No reply
--> {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
// No reply
--> {"jsonrpc": "2.0", "method": "temperature", "params": [], id: 1 }
<-- {"jsonrpc": "2.0", "result": 99, "id": 1}
{% endhighlight %}

In this interaction:

 * **notifications** are methods without id's, and do not have replies, and
 * **methods** use an id to tag a result.
 
This usage is reasonable, but we can do better. We want to bundle together
notifications and methods, to amortize the cost of network traffic, but
without comprising the API. Specifically, we want users to just write code
using `send`, and the RPC library to figure out the best bundling possible.

## The Remote Monad

In the remote monad theory, there are two key concepts:

 * Split the monadic primitives into commands and procedures. 
    * **Commands** do not have a result value (typically `()` in Haskell), and
    * **Procedures** have a result.

   There are restrictions on commands and procedures, specifically that they
   must be serializable.
 * Choosing a bundling strategy. There are two strategies that were documented in the original paper
   and one new bundling strategy that we are investigating.
    * **Weak**        - a bundle of a single command or a single procedure, or
    * **Strong**      - a bundle of a sequence of commands, optionally terminated by a procedure, or
    * **Applicative** - a bundle of a sequence of commands and procedures, held together using an applicative functor.
    
By factoring our primitives into commands and procedures, we can automatically split up a monadic computation
into maximal bundles, and then use a transport layer to send, execute and get
the result from each bundle. The good news is there is a library, called the 
[`remote-monad`](http://hackage.haskell.org/package/remote-monad),
that has a plug-and-play API. If we provide the best bundling transport we can, 
then the library can pick the best way of splitting up the monadic computation
into our bundles.

Considering JSON-RPC, the concept of notification and method map straight onto the
remote monad concepts of commands and procedures. This makes things straightforward.

### Weak Bundles

You can create a JSON-RPC instance using `weakSession`,
which takes an encoding of **how** to send values to a 
remote server, and returns a `Session`.

{% highlight haskell %}
weakSession :: (∀ a. SendAPI a -> IO a) -> Session
{% endhighlight %}

`∀ a. SendAPI a -> IO a` is a natural transformation.
Specifically, `∀ a. SendAPI a -> IO a` is a functor
morphism between `SendAPI` and `IO`. Or, operationally,
this transformation is how you **run** `SendAPI`,
using `IO`. `SendAPI` is a deep embedding of
both synchronous and asynchronous communications of JSON `Value`.

{% highlight haskell %}
data SendAPI :: * -> * where
  Sync  :: Value -> SendAPI Value	 
  Async :: Value -> SendAPI ()	 
{% endhighlight %}

So, calling `send` with `RPC` monadic remote commands
factors up the specifics commands, and calls the
natural transformation argument with either `Sync` or `ASync`.
With the `weakSession`, every primitive causes its own
`Sync` or `ASync`; there is no complex bundling.

You can write your own matcher for `SendAPI`, or use `remote-json-client`,
which provides a function that, when given a URL, returns
the `SendAPI` to `IO` natural transformation using the wreq library.

{% highlight haskell %}
clientSendAPI :: String -> (∀ a. SendAPI a -> IO a)
{% endhighlight %}

Putting this together, we get

{% highlight haskell %}
main :: IO ()
main = do
  let s = weakSession (clientSendAPI "http://www.wibble.com/wobble")
  t <- send s $ do
          say "Hello, "
          say "World!"
          temperature
  print t
{% endhighlight %}

Having selected the weak remote monad, we have the weakest JSON-RPC interaction -
three transactions.

{% highlight json %}
// (1)
--> {"jsonrpc": "2.0", "method": "say", "params": ["Hello. "]}
// No reply

// (2)
--> {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
// No reply

// (3)
--> {"jsonrpc": "2.0", "method": "temperature", "params": [], id: 1 }
<-- {"jsonrpc": "2.0", "result": 99, "id": 1}
{% endhighlight %}

### Strong Bundles

The strong remote monad bundles together commands, where possible, to amortize
the cost of the remote call. In our example above, we have two notifications,
and a method call. We want to combine them together. We do so by using the
`strongSession` combinator.

{% highlight haskell %}
main :: IO ()
main = do
  let s = strongSession (clientSendAPI "http://www.wibble.com/wobble")
  t <- send s $ do
          say "Hello, "
          say "World!"
          temperature
  print t
{% endhighlight %}

Now, we get a single transaction, which conforms to the JSON-RPC specification.

{% highlight json %}
--> [ {"jsonrpc": "2.0", "method": "say", "params": ["Hello. "]}
    , {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
    , {"jsonrpc": "2.0", "method": "temperature", "params": [], id: 1 }
    ]
<-- [ {"jsonrpc": "2.0", "result": 99, "id": 1}
    ]
{% endhighlight %}

Note: If we were to have a second method call at the end in the example above, then
the new method call would be in a second transaction by itself.

The same RPC `send` command gives better bundling, solely from changing the 
strategy from a `weakSession` to a `strongSession`. 
Now, the JSON-RPC specification says 

 * "The Server MAY process a batch rpc call as a set of concurrent tasks,
   processing them in any order and with any width of parallelism."

This is where it gets interesting. The RPC monad reflects the concurrency
policy of the the server, up to method calls. If you wish to insist on
sequentiality, then use the `weakSession`. 


## Applicative Bundles

One obvious question is "can we improve
this reflection of concurrency, and bundle method calls as well as notification?"
In [Haxl](https://github.com/facebook/Haxl), the Fackbook team use an even
stronger bundling strategy, which we call the applicative bundling strategy. In
this strategy, methods that are expressed using applicative functors can be
bundled together, as well as commands that can already be bundled.

The `remote-json` library supports applicative bundling. Again, the details
are abstracted by the library, and again the monad and applicative functor
reflect the concurrency semantics of the server. We've added a new remote
command `uptime` that returns the uptime of a specific machine, to aid
the demonstration of batching, and reworked the computation to use applicative.

{% highlight haskell %}
main :: IO ()
main = do
  let s = applicativeSession (clientSendAPI "http://www.wibble.com/wobble")
  (t,u) <- send s $ 
          say "Hello, " *>
          say "World!"  *>
          (pure (,) <*> temperature   
                    <*> uptime "orange")
  print (t,u)
{% endhighlight %}

The packet now includes two notifications and two methods. (Remember,
a notification is a JSON-RPC method that has no id tag.)

{% highlight json %}
--> [ {"jsonrpc": "2.0", "method": "say", "params": ["Hello. "]}
    , {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
    , {"jsonrpc": "2.0", "method": "temperature", "params": [], id: 1 }
    , {"jsonrpc": "2.0", "method": "uptime", "params": [], id: 2 }
    ]
<-- [ {"jsonrpc": "2.0", "result": 99, "id": 1}
    , {"jsonrpc": "2.0", "result": 4.29, "id": 2}
    ]
{% endhighlight %}

When [Applicative do](https://ghc.haskell.org/trac/ghc/wiki/ApplicativeDo) 
arrives, we can take immediate advantage of this, and start using
`do`-notation to write out remote applicative functors.

## Summary

We have written a remote monad for JSON-RPC. The library automatically bundles
inside `send` to attempt to amortize the cost of the remote procedure call. It
simplifies making multiple requests, without resorting to specialized variants
of `send`. 

We have been using `remote-json`, and its predecessors, on a number of projects here at KU
for several years now.  Feel free to try it out. 
In a future blog post, we will discuss how to use natural transformations
to implement a JSON-RPC server, and address the cost of
normalizing the remote monad before transmission.

Enjoy!

#### Resources and Related Work

 * [`remote-json`](http://hackage.haskell.org/package/remote-json)
 * [`remote-monad`](http://hackage.haskell.org/package/remote-monad)
 * [`haxl`](https://hackage.haskell.org/package/haxl)
 * [There is no fork:](http://dl.acm.org/citation.cfm?id=2628144)
    an abstraction for efficient, concurrent, and concise data access, 
    Simon Marlow and Louis Brandy	and Jonathan Coens	and Jon Purdy.
 * [Semi-implicit batched remote code execution as staging](http://okmij.org/ftp/meta-future/), Oleg Kiselyov
 * The [remote monad design pattern](/practice/remotemonad/)


#### Existing JSON-RPC packages

 * [`json-rpc`](http://hackage.haskell.org/package/json-rpc) by Jean-Pierre Rupp
 * [`json-rpc-client`](http://hackage.haskell.org/package/json-rpc-client) by Kristen Kozak
 * [`jsonrpc-conduit`](http://hackage.haskell.org/package/jsonrpc-conduit) by Gabriele Sales
 * [`colchis`](http://hackage.haskell.org/package/colchis) by Daniel Díaz Carrete
 * [`jmacro-rpc`](http://hackage.haskell.org/package/jmacro-rpc) by	Gershom Bazerman

#### Our Publications about the Remote Monad

{% include cite.fn key="Gill:15:RemoteMonad" %}
{% include cite.fn key="Grebe:16:Haskino" %}
