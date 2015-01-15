---
layout: page
title: "CAREER: Filling the Gaps in Domain-Specific Functional-Based Solutions for High-Performance Execution"
---

## Summary

This project is building a domain-specific language toolkit, called Wakarusa, that
makes domain-specific languages easier to deploy in high-performance scenarios.
The technology is going to be initially applied to two types of high-performance
platforms, GPGPUs and FPGAs.
However, the toolkit will be general purpose, and we expect the result will also
make it easier to deploy DSLs in situations where resource usage needs to be well-understand,
such as cloud resources and embedded systems.
The project is funded by the NSF.

--------------|------------------------------------------------------------------------------
**Title**     | CAREER: Filling the Gaps in Domain-Specific Functional-Based Solutions for High-Performance Execution
**Funded&nbsp;by**       | The National Science Foundation
**Link**                 | <http://www.nsf.gov/awardsearch/showAward?AWD_ID=1350901>
**Period of Performance** | June 2014 - May 2019
**Amount**               | $521,201

## Abstract

Physicists, meteorologists, and other users of high-performance
computing want to write large and complicated models and systems that
execute correctly and quickly. These models and systems are allowing
us to understand our world better, and explore solutions to hard
problems. Unfortunately, to make efficient use of computing resources,
a non-computing specialist needs to, for all intents and purposes,
become a proficient computer scientist. The fundamental problem is
that a non-computing specialist is not necessarily aware of available
options for optimizing their model. Domain Specific Languages (DSLs)
are one possible solution to this knowledge gap, because DSLs can
encode the necessary knowledge required to map programs onto
high-performance targets, at the same time to provide a customized
environment in the parlance of the domain specialist. By utilizing a
DSL, the non-specialist does not need to worry about performance at
the outset; it is the responsibility of the DSL compiler to map the
model onto the high-performance target. This research will produce new
DSL techniques and technologies that will substantially lower the cost
of developing such high-performance DSLs, as well as improve the
performance opportunities offered to users.

Over the five-year span of the project, two specific high-performance
parallel platforms (GPGPUs and FPGAs) will be made more accessible. A
resource-aware DSL will allow a broad range of parallel programming
idioms to be directly expressed. This resource-aware DSL will also
work in combination with existing DSLs. With the use of rewriting
technologies, the resource-aware DSL will act as an expressive common
medium for exploring design tradeoffs before, during and after the
commitment to specific implementation technologies. A set of custom
compiler plugins will allow translation into existing development
environments and tools for GPGPUs and FPGAs. As programming continues
to migrate from being the task of the general programmer into the
hands of domain specialists, the broader impact of this research is
lowering the performance-related knowledge burden on the domain
specialist, and more generally, supporting the use of specialists by
pushing the state-of-the-art in DSL design and implementation. The
principal intellectual merit of this research is the challenge of
creating the generic DSL that supports post-hoc and resource-aware
on-the-fly refactoring on user models. This new DSL will inform future
high-performance DSL compilers, and open opportunities for customized
DSLs and the domain specialist working together to find
implementations that execute correctly and quickly.

### Students

 * [Josh Filstrup](/people/joshfilstrup)  - Reification and deep embeddings
 * [Mark Grebe](/people/markgrebe) - Embedded systems plugin
 * [Mike Stees](/people/mikestees) - GPU support via Accelerate and Boost
 * David Young  - TDB
 * Angela Wright - Flight control implementation using Wakarusa (in conjunction with Aerospace).
 

### Project Name

[Wakarusa](http://en.wikipedia.org/wiki/Wakarusa_River) is a river just south of Lawrence, KS,
where the main campus of the University of Kansas is located. Wakarusa is approximately
translated as "deep river", and we use deep embeddings a key technology in our
DSL toolkit. 

### Publicity

 * <http://eecs.ku.edu/news/faculty-awards/2014/03/gill-wins-national-science/>



