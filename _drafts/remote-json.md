---
title: The Remote JSON library
layout: post
---

[JSON-RPC](http://www.jsonrpc.org/) is simple, well supported API for
remote procedure calls over the HTTP protocol. 
JSON-RPC supports both synchronous remote methods calls,
and asynchronous notifications. We want to access JSON-PRC from Haskell,
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
server responds. The packet being send is a simple JSON object, as is the 
reply from the server.

The JSON-RPC protocol supports batching
(sending several method calls and notifications at the same time),
is JSON based, which makes it easier to debug, because it is text-based,
and is widely supported. By using JSON-RPC we can implement our clients
in Haskell, and not care what the server is written in.

There are a number of existing Haskell libraries that support
JSON-RPC, but we wanted to build our own for two reasons.

 * First, by using the remote monad design pattern
   we can automate taking advantage of the batch capability,
   amortizing the cost of the remote call. Rather than have
   separate entry point, an single entry point can provide
   both batched and singleton calls, simplifying the API.
   
 * Second, we wanted to experiment with using natural transformations
   as a first-class idiom for building network stacks.

Lets go ahead and design our API, show two examples of usage, before
exploring the implementation details.

## Basic Design of the JSON-RPC API

We center our design around the `RPC` monad.

{% highlight haskell %}
data RPC :: * -> *

method       :: Text -> Args -> RPC Value
notification :: Text -> Args -> RPC ()

send         :: Session -> RPC a -> IO a
{% endhighlight %}

This is a classical remote monad design - a restricted monad, a small number of primitives
for this monad, and a `send` function. `Session` is an abstract handle to the web server
we want to talk to; we'll come back to this.

This API gives an untyped access to JSON-RPC.
As an example, consider sending two `say` notifications, that make the remote
server say things, and a `temperature` method.

{% highlight haskell %}
example :: Session -> IO ()
example s = do
  t <- send s $ do
          notification "say" (List [String "Hello, "])
          notification "say" (List [String "World!"])
          method "temperature" None
  print t
{% endhighlight %}
  
### Added a typed varient around our JSON-RPC API

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

Both examples generate the same session interactions with the server. `send` can be used
multiple times if needed, acting as translation between our `IO` monad, and the remote `RPC`/`DSL` monad.

### What happens at the JSON-RPC level

For our Hello, World example, here is a possible JSON-RPC interaction log.

{% highlight json %}
--> {"jsonrpc": "2.0", "method": "say", "params": ["Hello. "]}
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
using `send`, and the RPC library figure out the best bundling possible.

## The Remote Monad

In the remote monad theory, there are two key concepts:

 * We split our monadic primitives into commands and procedures. 
    * **Commands** do not have a result value (typically `()` in Haskell), and
    * **Procedures** have a result.

   There are restrictions on commands and procedures, specifically that they
   can be serializable.
 * We choose a bundling strategy. There are three that have been investigated.
    * **Weak** - a bundle of a single command or a single procedure, and
    * **Strong** - a bundle of a sequence of commands, optionally terminated by a procedure, and
    * **Applicative** - a bundle of commands and procedures bound together by an applicative functor.
    
By factoring our primitives, we can automatically split up a monadic computation
into maximal bundles, and then use a transport layer to send, execute and get
the result from each bundle. The good news is there is a library, called the `remote-monad`,
that has a plug-and-play API. If we provide the best bundling transport we can, 
and the library can pick the best way of splitting up the monadic computation
into our bundles.

Considering JSON-RPC, the concept of notification and method map straight onto the
remote monad concepts of commands and procedures. This makes things straightforward.

### Weak Bundles

### Strong Bundles

### Applicative Bundles

## Summary

We have written a remote monad for JSON-RPC. The library automatically bundles
inside `send` to attempt to amortize the cost of the remote procedure call. It
simplifies making multiple requests, without resorting to specialized variants
of `send`.

We have been using `remote-json` on a number of projects here at KU for about 
a year, though the applicative bundle has just come online. Feel free to try
it out. In a future installment, we will discuss how to use natural transformations
to implement a JSON-RPC server.

Enjoy!

#### Resources

 * `remote-json`
 * `remote-monad`
 * The [remote monad design pattern](/practice/remotemonad/)

#### Publications

{% include cite.fn key="Gill:15:RemoteMonad" %}
{% include cite.fn key="Grebe:16:Haskino" %}







 





