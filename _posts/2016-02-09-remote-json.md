---
title: The Remote JSON library
layout: post
---

[JSON-RPC](http://www.jsonrpc.org/) is a simple and well supported protocol for
remote procedure calls over HTTP, 
supporting both synchronous remote methods calls 
and asynchronous notifications. We want to access JSON-RPC from Haskell,
but in a principled way. This blog post discusses the design and user-facing interface
of [`remote-json`](http://hackage.haskell.org/package/remote-json),
a new library for JSON-RPC that makes use of the
[remote monad design pattern](/practice/remotemonad/)

<!--MORE-->

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
a single entry point can provide both batched and singleton calls.
The library also acts as a case study of using the remote monad.

## Basic Design of the JSON-RPC API

We center our design around the `RPC` monad.

{% highlight haskell %}
-- The monad
data RPC :: * -> * deriving (Monad, Applicative, Functor)

-- The primitives
method       :: FromJSON a => Text -> Args -> RPC a
notification ::               Text -> Args -> RPC ()

-- the remote send
send         :: Session -> RPC a -> IO a

{% endhighlight %}

This is a classical remote monad design - a restricted monad, a small number of primitives
for this monad, and a `send` function. `Session` is an abstract handle to the web server
we want to talk to; we'll come back to how to generate a `Session` shortly.

This API gives an (aeson) Value-based access to JSON-RPC. Adding specific primitives gives
stronger typing. As an example, consider providing `say` notifications, that make the remote
server say things,  a `temperature` method that returns the remote server's temperature,
and an `uptime` method that returns the uptime of a specific service.

{% highlight haskell %}
say :: Text -> RPC ()
say msg = notification "say" $ List [String msg]

temperature :: RPC Int
temperature = method "temperature" None

uptime :: Text -> RPC Double
uptime nm = method "uptime" $ List [String nm]

-- provided utilities for generating Args, and parsing the Value result of a method.
List   :: [Value] -> Args
None   :: Args
{% endhighlight %}

As an example we have our typed API for `temperature`, `uptime` and `say`, saying "Hello, World!",
getting the temperature, and the uptime of "orange".

{% highlight haskell %}
example :: Session -> IO ()
example s = do
  (t,u) <- send s $ do
          say "Hello, "
          t <- temperature
          say "World!"
          u <- uptime "orange"
          return (t,u)
  print t
  print u  
{% endhighlight %}

`send` can be used
multiple times if needed, acting as translation between our `IO` monad, and the remote `RPC` monad.
Furthermore, the following JSON-RPC interaction with the server would be a valid
trace of interactions for the above example. 

{% highlight json %}
--> {"jsonrpc": "2.0", "method": "say", "params": ["Hello, "]}
// No reply

--> {"jsonrpc": "2.0", "method": "temperature",  id: 1 }
<-- {"jsonrpc": "2.0", "result": 99, "id": 1}

--> {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
// No reply

--> {"jsonrpc": "2.0", "method": "uptime", "params": ["orange"], id: 1 }
<-- {"jsonrpc": "2.0", "result": 3.14, "id": 1}
{% endhighlight %}

In this interaction:

 * **notifications** are methods without id's, and do not have replies, and
 * **methods** use an id to tag a result.
 
This usage is reasonable, **but we can do better**. We want to bundle together
notifications and methods, to amortize the cost of network traffic, but
without comprising the API. Specifically, we want users to just write code
using `send`, and the RPC library to figure out the best bundling possible.

## The Remote Monad

In the remote monad theory, there are two key concepts:

 * Splitting the monadic primitives into commands and procedures. 
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
the result from each bundle. The good news is there is a library, called
the [`remote-monad`](http://hackage.haskell.org/package/remote-monad),
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
weakSession :: (SendAPI :~> IO) -> Session
{% endhighlight %}

`SendAPI  :~> IO` is a natural transformation.

{% highlight haskell %}
newtype f :~> g = Nat (∀ a. f a -> g a)
{% endhighlight %}

Specifically, `SendAPI  :~> IO` is a functor
morphism between `SendAPI` and `IO`,
and isomorphic to `∀ a. SendAPI a -> IO a`.
Operationally,
this transformation is how you **run** `SendAPI`,
using `IO`. `SendAPI` is a deep embedding of
both synchronous and asynchronous communications of JSON `Value`.

{% highlight haskell %}
data SendAPI :: * -> * where
  Sync  :: Value -> SendAPI Value	 
  Async :: Value -> SendAPI ()	 
{% endhighlight %}

So, calling `send` with the `RPC` monadic remote commands
factors up the specifics commands, and calls the
natural transformation argument with either `Sync` or `ASync`.
With the `weakSession`, every primitive causes its own
`Sync` or `ASync`; there is no complex bundling.

You can write your own matcher for `SendAPI`, or use 
[`remote-json-client`](http://hackage.haskell.org/package/remote-json-client),
which provides a function that, when given a URL, returns
the `SendAPI` to `IO` natural transformation using the 
[`wreq`](http://hackage.haskell.org/package/wreq) library.

{% highlight haskell %}
clientSendAPI :: String -> (SendAPI :~> IO)
{% endhighlight %}

Putting this together, we get

{% highlight haskell %}
main :: IO ()
main = do
  let s = weakSession (clientSendAPI "http://www.wibble.com/wobble")
  (t,u) <- send s $ do
          say "Hello, "
          t <- temperature
          say "World!"
          u <- uptime "orange"
          return (t,u)
  print t
  print u  
{% endhighlight %}

Having selected the weak remote monad, we have the weakest JSON-RPC interaction -
four transactions.

{% highlight json %}
// (1)
--> {"jsonrpc": "2.0", "method": "say", "params": ["Hello, "]}
// No reply
// (2)
--> {"jsonrpc": "2.0", "method": "temperature", id: 1 }
<-- {"jsonrpc": "2.0", "result": 99, "id": 1}
// (3)
--> {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
// No reply
// (4)
--> {"jsonrpc": "2.0", "method": "uptime", "params": ["orange"], id: 1 }
<-- {"jsonrpc": "2.0", "result": 3.14, "id": 1}
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
  (t,u) <- send s $ do
          say "Hello, "
          t <- temperature
          say "World!"
          u <- uptime "orange"
          return (t,u)
  print t
  print u  
{% endhighlight %}

Now, we get a two transactions, which conforms to the JSON-RPC specification.

{% highlight json %}
--> [ {"jsonrpc": "2.0", "method": "say", "params": ["Hello. "]}
    , {"jsonrpc": "2.0", "method": "temperature", id: 1 }
    ]
<-- [ {"jsonrpc": "2.0", "result": 99, "id": 1}
    ]
--> [ {"jsonrpc": "2.0", "method": "say", "params": ["World "]}
    , {"jsonrpc": "2.0", "method": "uptime", "params": ["orange"], id: 1 }
    ]
<-- [ {"jsonrpc": "2.0", "result": 3.14, "id": 1}
    ]
{% endhighlight %}

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
Yes! For example, [Haxl](https://github.com/facebook/Haxl),
a Haskell DSL for database access, 
uses an even stronger bundling strategy, which we call the applicative bundling strategy.
In this strategy, methods that are expressed using applicative functors can be
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
          (pure (,) <*> temperature   
                    <*  say "World!"
                    <*> uptime "orange")
  print (t,u)
{% endhighlight %}

The packet now includes two notifications and two methods. (Remember,
a notification is a JSON-RPC method that has no id tag.)

{% highlight json %}
-->  [ {"jsonrpc":"2.0","params":["Hello,"],"method":"say"}
     , {"jsonrpc":"2.0","method":"temperature","id":2},
     , {"jsonrpc":"2.0","params":["World!"],"method":"say"}
     , {"jsonrpc":"2.0","params":["orange"],"method":"uptime","id":1}
     ]
<-- [ {"result":65,"jsonrpc":"2.0","id":2}
    , {"result":68.28,"jsonrpc":"2.0","id":1}
    ]
{% endhighlight %}

When [Applicative do](https://ghc.haskell.org/trac/ghc/wiki/ApplicativeDo) 
arrives with GHC 8, we can take immediate advantage of this, and start using
`do`-notation to write out remote applicative functors. In fact, we can
interperse our usage of monads and applicative `RPC`, and the package
will choose the best bundling it can for the specific strategy.

## Summary

We have written a remote monad for JSON-RPC. The library automatically bundles
inside `send` to attempt to amortize the cost of the remote procedure call. It
simplifies making multiple requests, without resorting to specialized variants
of `send`. 
These idea has been used before. For example,
Haxl lead the charge of using the 
applicative bundling strategy,
and Oleg implemented a remote monad in OCaml several years ago.
And we've been using predecessors to `remote-json` for several years now. 
Feel free to try `remote-json`, and if you are adventurous, `remote-monad`.
Or roll your own remote monad. Once you know the pattern, it's quite straightforward!

In a future blog post, we will look at our JSON-RPC server.

Enjoy!

Justin Dawson and Andy Gill

## Resources and Related Work

 * [`remote-json`](http://hackage.haskell.org/package/remote-json)
 * [`remote-monad`](http://hackage.haskell.org/package/remote-monad)
 * [`haxl`](https://hackage.haskell.org/package/haxl)
 * [There is no fork:](http://dl.acm.org/citation.cfm?id=2628144)
    an abstraction for efficient, concurrent, and concise data access, 
    Simon Marlow and Louis Brandy	and Jonathan Coens	and Jon Purdy.
 * [Semi-implicit batched remote code execution as staging](http://okmij.org/ftp/meta-future/), Oleg Kiselyov
 * The [remote monad design pattern](/practice/remotemonad/)


### Existing JSON-RPC packages

 * [`json-rpc`](http://hackage.haskell.org/package/json-rpc) by Jean-Pierre Rupp
 * [`json-rpc-client`](http://hackage.haskell.org/package/json-rpc-client) by Kristen Kozak
 * [`jsonrpc-conduit`](http://hackage.haskell.org/package/jsonrpc-conduit) by Gabriele Sales
 * [`colchis`](http://hackage.haskell.org/package/colchis) by Daniel Díaz Carrete
 * [`jmacro-rpc`](http://hackage.haskell.org/package/jmacro-rpc) by	Gershom Bazerman

### Our Publications about the Remote Monad

{% include cite.fn key="Gill:15:RemoteMonad" %}
{% include cite.fn key="Grebe:16:Haskino" %}
