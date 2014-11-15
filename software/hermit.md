---
layout: page
title: The Haskell Equational Reasoning Model-to-Implementation Tunnel (HERMIT)
redirect_from:
 - /Tools/HERMIT
---
The **Haskell Equational Reasoning Model-to-Implementation Tunnel**
(HERMIT) is a GHC plugin that allows post-hoc transformations
to be applied to Haskell programs, after compilation has started.
HERMIT can be used for program-specfic optimizations,
domain-specific optimzations, or for constructing semi-formal
assurance arguments.

## Architecture

![](/images/software/hermit/hermit-arch2.png)

The HERMIT Package
------------------

* On Hackage: <http://hackage.haskell.org/package/hermit>
* On Github: <https://github.com/ku-fpg/hermit>

Publications
------------

{% include cite.fn key="Farmer-14-HERMITinStream" %}
{% include cite.fn key="Adams-14-OSIE" %}
{% include cite.fn key="Sculthorpe-13-KURE" %}
{% include cite.fn key="Sculthorpe-13-HERMITinTree" %}
{% include cite.fn key="Farmer-12-HERMITinMachine" %}
