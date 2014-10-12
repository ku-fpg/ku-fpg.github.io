---
layout: page
title: "Efficient Hardware Implementation of Iterative FEC Decoders"
---

--------------|------------------------------------------------------------------------------
**Title**     | High-Rate High-Speed Forward Error Correction Architectures for Aeronautical Telemetry
**Funded&nbsp;by**       | T&E/S&T Program, U.S. Army 
**Period of Performace** | May 2009 - Aug 2011 
**Investigators**        | Erik Perrins (PI), Andrew Gill (Co-PI)
**Amount**               | $799,267

## Abstract

Modern forward error correcting (FEC) codes with high-performance
iterative decoders are of tremendous interest in the wireless
communications research community. On the practical side, these codes
have already been adopted in many wireless communication standards and
are under consideration in numerous future standards. The widespread
use of these codes places tremendous importance on decoder design and
implementation. The goal of this research is to develop hardware FEC
decoders that are efficient in their use of hardware resources and
implementation effort. While our approach is quite general and is
widely applicable, we focus on low density parity check (LDPC) codes
and serially concatenated convolutional codes (SCCC) as design
examples.

## Use of Functional Programming

On this project, we used [Kansas Lava](/software/kansas-lava)
to generate efficient forward
error correcting codes. From a research point of view, we were attempting
to to answer the following questions:

-   Can we use use functional programming to complement and support the
    current development module of using MATLAB for a reference, and VHDL
    for an implementation.
-   Can we build a functional program that mitigates against the need to
    perform frequent refactorings when working in VHDL, as a suitable
    architecture is discovered.
-   Can we gain a stronger assurance of the relationship between the
    specification and implementation?
-   What are the weaknesses of using a system like Lava to implement a
    FEC, and what are the remaining research problems with using EDSLs
    as an architecture bridge.

## Relevent Publications

{% include cite.fn key="Gill-13-TypesKansasLava" %}
{% include cite.fn key="Gill-12-PatchLogic" %}
{% include cite.fn key="Gill-11-Declarative" %}
{% include cite.fn key="Gill-11-DerivingLDPC" %}
{% include cite.fn key="Gill-11-GeneratingLDPC" %}
{% include cite.fn key="Bull-11-FECandFP" %}
{% include cite.fn key="Gill-10-TypesKansasLava" %}
{% include cite.fn key="Farmer-10-WhatsTheMatter" %}
{% include cite.fn key="Gill-09-KansasLava" %}
{% include cite.fn key="Werling-09-ITC" %}
{% include cite.fn key="Bull-09-ITC" %}

