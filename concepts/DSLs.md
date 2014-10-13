---
layout: page
title: Domain Specific Languages
---




Communication Model			     | Example            | Shallow Embedding	  | Deep Embedding 
---------------------------------------------|--------------------|------------------------|---------------
Transaction<BR>*Things happen cooperatively* | Erlang,<BR>Timber  | STMs,<BR>Cloud Haskell<BR>Hawk | ???
Synchronous<BR>*Things happen in step*	     | Esterel,<BR>Lustre | Hawk, Lava		  | Lava
Continuous<BR>*Things happen all the time*   | Simulink		  | Yampa		  | Wakarusa


Domain		      			   | Mainstream system	 | Shallow Embedding   | Deep Embedding 
-------------------------------------------|---------------------|---------------------|----------------
Array<BR>*Things happen to collections*    | CUDA, OpenCL	 | Repa		       | Accelerate 
HTML5 Graphics	 	   		   | JavaScript Canvas   | Blank Canvas (send) | Sunroof 

Shallow embedings must be directed executed on the Haskell runtime system,
Deep embeddings are typically computed on a different platform.

## Functors

It can be useful to think in terms of a functor over these communication models.


