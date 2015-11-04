---
title: The Remote Monad Design Pattern
layout: post
---

Remote Procedure Calls (RPCs) are expensive. This blog article,
based on our [Haskell symposium paper](http://ku-fpg.github.io/papers/Gill-15-RemoteMonad/),
presents a way to make them
considerably cheaper: the *remote monad design pattern*.
The idea is that, rather than directly call a remote procedure,
we instead give the remote procedure call a service-specific monadic
type, and invoke the remote procedure call using a monadic ``send'' function.
Specifically, A **remote monad** is a monad that has its evaluation function in
a remote location, outside the local runtime system.

<!--MORE-->

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
