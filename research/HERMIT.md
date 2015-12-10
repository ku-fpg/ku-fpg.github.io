---
layout: page
title: Improving the Applicability of Haskell-Hosted Semi-Formal Models to High Assurance Development
---

## Summary

This project is building a post-hoc transformation system inside a full scale Haskell compiler.
This will improve the connections between
Haskell models and Haskell implementations, as well allow
the exploration of the powerful worker/wrapper transformation.
The project is funded by the NSF.

--------------|------------------------------------------------------------------------------
**Title**     | Improving the Applicability of Haskell-Hosted Semi-Formal Models to High Assurance Development
**Funded&nbsp;by**       | The National Science Foundation
**Link**                 | <http://www.nsf.gov/awardsearch/showAward?AWD_ID=1117569>
**Period of Performance** | August 2011 - July 2015
**Amount**               | $527,750 ($495,750 + 2 REUs of 16,000)

## Abstract

In engineering practice, models are
an essential part of understanding how to build complex systems. In
this project, high-level models and efficient implementations of
computer systems will be developed side-by-side under a single
framework that bridges the gap between them using a high degree of
automation. This is possible due to the use of a modern functional
language for both the model and implementation, and the deployment of
a new and powerful general-purpose and semi-automatic refinement technology.
The functional language Haskell has already enjoyed considerable
success as a platform for high-level modeling of complex systems with
its mathematical-style syntax, state-of-the-art type system, and
powerful abstraction mechanisms.

In this project, Haskell will be used to express a semi-formal
model and an efficient implementation, taking the form of two distinct
expressions of computation with the same mathematical foundation.
The project develops tools and methodologies that use transformations like
the worker/wrapper transformation to construct links between these models
and implementations, lowering the cost of the development of
high-assurance software and hardware components in application
areas like security kernels and critical control systems.
Lowering the cost of linking semi-formal specifications and models to
real implementations will have considerable
impact. For example, Evaluation Assurance Level (EAL) 5 and 6 of the
Common Criteria call for semi-formal methods to construct such links,
and this project addresses keys part of this requirement.

## Final Summary

In engineering practice, models are an essential part of understanding
how to build complex systems. In this investigation, we constructed
a tool we called HERMIT, which mechanized the connections between
a specific class of software models, and their programatic counterparts.
We have used HERMIT on a number of case studies, pushing the state-of-the-art
in semi-formal mathematical reasoning for software development.

Functional programming is a promising approach to writing programs
which are both correct and fast. Functional programming is based on
the idea of using mathematical functions to construct
programs. With effort, it is possible to establish a connection
between a model written in a functional language, 
and a fast implementation, via program transformation.

HERMIT is a software artifact that fits in the gap between
mathematically formal tools for reasoning about programs, and informal
techniques such as pen-and-paper derivations. HERMIT attaches to the
popular Glasgow Haskell compiler, the premier compiler for the lazy
functional language Haskell, providing new tools and techniques for
mechanizing reasoning and program transformations.  This architecture
allows HERMIT to be the first system capable of directly reasoning
about the full Haskell language.

Using HERMIT, we completed five case studies that connected models with
implementations. There included that specific critical properties
of a software library hold in the given cases, running efficient simulations
of cellular automata, and mechanizing a proof that a well-known
implementation of a mathematical property holds. Further, two
case studies resulted in state-of-the-art optimized implementations,
resulting in the solution to an open problem in optimization,
and giving a way to write more expressive programs without compromising
the speed of the final program.

This project resulted in 11 publications, one PhD dissertation,
and one MS thesis.

## Relevant Publications

{% include cite.fn key="Gill-15-RemoteMonad" %}
{% include cite.fn key="Farmer-15-HERMIT-reasoning" %}
{% include cite.fn key="Adams-15-OSTIE" %}
{% include cite.fn key="Farmer-15-PhD" %}
{% include cite.fn key="Torrence:15:Life" %}

{% include cite.fn key="Sculthorpe-14-KURE" %}
{% include cite.fn key="Sculthorpe-15-WorkIt" %}
{% include cite.fn key="Gill-14-DSLs-and-Synthesis" %}
{% include cite.fn key="Farmer-14-HERMITinStream" %}
{% include cite.fn key="Adams-14-OSIE" %}

{% include cite.fn key="Sculthorpe-13-HERMITinTree" %}
{% include cite.fn key="Sculthorpe-13-ConstrainedMonad" %}
{% include cite.fn key="Farmer-12-HERMITinMachine" %}

### Background Publications

These publications supported the original proposal.

"Deriving an efficient FPGA ..." was a case study of using worker/wrapper, applied
to hardware synthesis.

{% include cite.fn key="Gill-11-DerivingLDPC" %}

"The worker/wrapper transformation" was the first formalization of worker/wrapper.

{% include cite.fn key="Gill-09-WW" %}








