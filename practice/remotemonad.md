---
title: The Remote Monad Design Pattern
layout: page
---

The **remote monad design pattern** is a way of
making Remote Procedure Calls (RPCs), and other
calls that leave the Haskell eco-system, considerably less expensive.
The idea is that, rather than directly call a remote procedure,
we instead give the remote procedure call a service-specific monadic
type, and invoke the remote procedure call using a monadic "send" function.
Specifically, A **remote monad** is a monad that has its evaluation function in
a remote location, outside the local runtime system.

## Introducing a Example Remote Monad 

By factoring the RPC into sending invocation and service name,
we can group together procedure calls, and amortize the cost
of the remote call. To give an example, [Blank Canvas](https://hackage.haskell.org/package/blank-canvas),
our library for remotely accessing the JavaScript HTML5 Canvas, has
a `send` function, `lineWidth` and
`strokeStyle` services, and our remote monad is called
`Canvas`:

{% highlight Haskell %}
send        :: Device -> Canvas a -> IO a
lineWidth   :: Double             -> Canvas ()
strokeStyle :: Text               -> Canvas ()
{% endhighlight %}

If we wanted to change the (remote) line width,
the `lineWidth` RPC can be invoked by combining `send`
and `lineWidth`:

{% highlight haskell %}
send device (lineWidth 10)
{% endhighlight %}

Likewise, if we wanted to change the (remote) stroke color,
the `strokeStyle` RPC can be invoked by combining `send`
and `strokeStyle`:

{% highlight haskell %}
send device (strokeStyle "red")
{% endhighlight %}

The key idea of this paper is that *remote* monadic commands can
be *locally* combined before sending them to a remote server.
For example:

{% highlight haskell %}
send device (lineWidth 10 >> strokeStyle "red")
{% endhighlight %}

The complication is that, in general, monadic commands can return a result, which may be used by subsequent commands.
For example, if we add a monadic command that returns a Boolean,

{% highlight haskell %}
isPointInPath :: (Double,Double) -> Canvas Bool
{% endhighlight %}

we could use the result as follows:

{% highlight haskell %}
   send device $ do
      inside <- isPointInPath (0,0)
      lineWidth (if inside then 10 else 2)
      ...
{% endhighlight %}

The invocation of `send` can also return a value:

{% highlight haskell %}
  do res <- send device (isPointInPath (0,0))
     ...
{% endhighlight %}

Thus, while the monadic commands inside `send` are executed in a *remote* location,
the results of those executions need to be made available for use *locally*.
**This is the remote monad design pattern.**

## Uses of the Remote Monad Design Pattern


Once the Remote Monad design pattern is understood, many instances of
its use, or of related patterns, can be observed in the wild.
Here we highlight some examples, and give the type of the `send` analog.

Package | Remote Monad | `send` 
--------|--------------|--------
ncurses | `Curses`       | `runCurses :: Curses a -> IO a`
HAXL    | `GenHaxl u`    | `runHaxl :: ... -> GenHaxl u a -> IO a`
mongoDB | `Action m`     | `access :: ... -> Action m a -> m a`
Haste   | `Remote (...)` | `onServer :: ... -> Remote (Server a) -> Client a`
Sunroof  | `JS t`        | `rsyncJS :: JS t a  -> IO a`
hArduino | Arduino       | `withArduino :: ...  -> Arduino () -> IO ()`
bus-pirate | BusPirateM  | `runBusPirate :: ... -> BusPirateM a -> IO (Either String a)`
&#955;-bridge | BusCmd   | `send :: ... -> BusCmd a -> IO (Maybe a)`
threepenny-gui | UI      | `runUI :: ... -> UI a -> IO a`
accelerate | Arr         | `runIn :: ... -> Acc a -> a`
sbv        | Symbolic    | `runSymbolic' :: ... -> Symbolic a -> IO (a, Result)`
mcpi       | MCPI        | `runMCPI :: MCPI a -> IO a`
remote-json | RPC        | `send :: ... -> RPC a -> IO a`
