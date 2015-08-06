---
title: 2 New KU FPG Papers
layout: default
---

Two papers from the University of Kansas Functional Programming Group have been accepted for publication at Haskell'15! One about using 
HERMIT for equational reasoning, and the other about a monad-based design pattern for remote control that externalizes monadic 
execution. We've put the preprints on our webpage.

<!--MORE-->

## Reasoning with the HERMIT: Tool support for equational reasoning on GHC core programs

{% include cite.fn key="Farmer-15-HERMIT-reasoningo" %}

A benefit of pure functional programming is that it encourages equational reasoning. However, the Haskell language has lacked direct 
tool support for such reasoning. Consequently, reasoning about Haskell programs is either performed manually, or in another language 
that does provide tool support (e.g. Agda or Coq). HERMIT is a Haskell-specific toolkit designed to support equational reasoning and 
user-guided program transformation, and to do so as part of the GHC compilation pipeline. This paper describes HERMIT’s recently 
developed support for equational reasoning, and presents two case studies of HERMIT usage: checking that type-class laws hold for 
specific instance declarations, and mechanising textbook equational reasoning.

## The remote monad design pattern

{% include cite.fn key="Gill-15-RemoteMonad" %}

Remote Procedure Calls are expensive. This paper demonstrates how to reduce the cost of calling remote procedures from Haskell by using 
the remote monad design pattern, which amortizes the cost of remote calls. This gives the Haskell community access to remote 
capabilities that are not directly supported, at a surprisingly inexpensive cost.

We explore the remote monad design pattern through six models of remote execution patterns, using a simulated Internet of Things 
toaster as a running example. We consider the expressiveness and optimizations enabled by each remote execution model, and assess the 
feasibility of our approach. We then present a full-scale case study: a Haskell library that provides a Foreign Function Interface to 
the JavaScript Canvas API. Finally, we discuss existing instances of the remote monad design pattern found in Haskell libraries.

- Enjoy!

KU@FPG
