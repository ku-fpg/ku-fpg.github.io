---
layout: page
title: Research
---
We use functional programming to solve problems in ways that are
amicable to acceleration (GPUs, Multi-cores, FPGAs), and supports
assurance arguments (using semi-formal methods like equational
reasoning). As a group we make aggressive use of functional languages,
extending the technology where needed, and ultimately strive to close
gaps between high level specifications and highly efficient
implementations. We then deploy our new technologies into diverse
application areas, including telemetry, high performance computing and
real-time systems.

Our operating assumption is that a well written functional program can
perform effectively as a concise executable specification of a solution
to a problem. However, the scope and influence of our ideas is intended
to be broader than simply their use inside our functional language
community.

## Funded Research

Project            |  Funded<BR>by | Period of<BR>Peformanace  |  Investigators   | Amount  |
-------------------|:-------|-----------------|:-----------------|---------:|
[CAREER: Filling the Gaps in Domain-Specific<BR>Functional-Based Solutions for<BR>High-Performance Execution](/research/CAREER) | NSF | Jun 2014 -<BR> Apr 2019     | Andrew Gill (PI) | $521,201
[Armored Software](http://armoredsoftware.github.io/)   | DoD | Sep 2013 -<BR>Sep 2017     | Perry Alexander (PI)<BR>Andrew Gill<BR>Prasad Kulkarni | $2,708,071
[Improving the Applicability of Haskell-Hosted<BR>Semi-Formal Models to High Assurance<BR>Development](/research/HERMIT) (The HERMIT Project)    | NSF | Aug 2011 -<BR>Jul 2015     | Andrew Gill (PI) | $527,750
[High-Rate High-Speed Forward Error<BR>Correction Architectures for<BR>Aeronautical Telemetry](/research/HFEC) (HFEC) | DoD |  May 2009 -<BR>Aug 2011 | Erik Perrins (PI)<BR>Andrew Gill | $799,267
	  

## Overview of Research

It is **possible** to write specification style, high-level
implementation (or model) in our language of choice, Haskell, as well as
in other languages. This model may be relatively efficient as a model,
but be completely unsuitable for deployment. The model may lack specific
fidelity details, or be intended for a platform with a small footprint,
or deployment may have unrealizable throughput requirements. All of
these concerns can be addressed, and addressed from within our language
of choice, **but at the cost of compromising the clarity of the original
specification.**

It is also **possible** to write very fast programming in Haskell, or
programs that use finite heap, so could be run on an embedded platform,
or can be captured using a technique called deep embedding, so they
could be cross compiled onto alternative platforms like FPGAs or
graphics cards. However, **each of these techniques fundamentally
compromised some level of clarity**, and therefore negating one of the
reasons to use a functional language in the first place.

As a group, we want to be able to use functional programming language
technology as a bridge between both these programming styles, or more
generally between specification and implementation. 

## Other Sponsors

We would like to thank our other sponsors for supporting our research.

 * NVIDIA for donating a K-20 GPGPU to FPG@KU.
 * International Foundation for Telemetering (IFT) for
   funding for hardware, travel and student scholarships.
 * Xilinx for software and hardware through the Xilinx University Program.
 * Altera for software and hardware through the Altera University Program.
