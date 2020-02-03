---
layout: blank-page
title: "EECS448: Project 1"
---

Project 1: Event Planner
========================

EECS 448, Spring 2020
---------------------

### Code Freeze Date

All teams must have a code freeze as of **February 21st** at 5pm.
The timestamp will be judged by the final
commit on your master branch of the team\'s GitHub repository.

You can continue to work on other branches but cannot update your master
branch after the freeze date. You must demo the code base on the master
branch as of the code freeze.

------------------------------------------------------------------------

### GitHub

Your project GitHub repository needs to be **private**. Add your
teammates, your instructor and your TA as collaborators. Instructor\'s
and TA\'s GitHub usernames are:

  * andygill
  * sushmitha4-cloud

### Overview

We\'re going to make a program to help people schedule events. Similar
to [Doodle](https://doodle.com/), if you need an example.

### Requirements

There will be two modes in our program: creating an event (done by 1
person) and adding available times (done by multiple people).

#### Event Admin Mode

In this mode, a user can create an event and check on the status of an
event.
To create an event, the user will pick a single date and a series of
times on that date that he/she is available

-   The event will have a name
-   The date must be a real one (e.g. no February 30th)
-   The times must have an option for being displayed in 12 hour mode or
    24 hour mode; the timezone is Central Daylight Time (CDT).
-   A single time slot should be 20 minutes
-   An event can span multiple time slots (e.g. a two-hour event would
    occupy six time slots)
    Example: I want to schedule a party for Sunday, February 2nd, and
    name the event "Alex\'s SuperBowl Party". I also want to specify
    that I'm available at 4pm, 4:20pm, 4:40pm, 5:00pm, 5:20pm, 5:40pm
    (essentially I'm free from 4pm to 6pm).
-   The time slots do not have to be contiguous but must fall within the
    24-hours of a given date
-   The following time slots should never be available for meetings:
    12am - 5am, 12pm-1pm. In other words, no meetings between these
    hours.
-   The following days should not be available for scheduling meetings:
    December 25, January 1, and July 4.
-   The creator of the event should be listed as an attendee of the
    event

After a user creates an event they will save it and then future users
will be able to find this event and add their availability. In the user
mode, a user will indicate whether or not they are available. In admin
mode, the creator of the event should be able to quickly learn how many
attendees are available for any given time slot.

#### Adding Availability Mode

In this mode, users will be able to see a list of events that have been
created (from the other mode). They may select an event then do the
following:

-   For each time slot, the user will indicate whether or not they are
    available

Some aspects that are up to you to decide on:

-   The details must be retained between runnings of the program (You
    dont **need** to use a database in this project, and luckily we all
    learned file I/O!)
-   Menus to interact with the program
-   How to deal with the users across multiple sessions
-   You can choose **any** programming language and platform you consider
    appropriate for this type of project

### Team Meetings

You will have the lab session of the week of February 10th for team
meetings and/or working on project.
Meetings are to take place in the lab. 
If you plan/prefer to meet somewhere else, email your TA and
inform her about this.

### Plagiarism

You can use existing libraries, but you must cite all sources of code
you did not author in your documentation.

### Team Score (70% of individual grade)

This portion of the project will be judged by myself and the TA. The
project points are broken down into the following sections.

#### Presentation (10%)

Each team will give a presentation in class to go over the development
process and demo their product. A slide set isn't required, but the
following topics must be discussed in the presentation:

-   Overview of the platform
-   Description on how work was split between teammates
-   Challenges and how they were overcome or dealt with
-   Any features that did not make the demo version
-   Retrospective on what the team would have done different
-   Security considerations
-   Be professional (no need to dress up, but you need present yourself
    and your work in a professional way)

#### Modularity (10%)

In short, your code should be:

-   well structured (for example, object oriented)
-   easily extensible
-   divided into logical components (i.e. not one class that does
    everything)

More details in lectures.

#### Stability (20%)

You demo the code in class and the TA and myself will stress test your
application at our leisure. Crashes, memory leaks, or other things that
you also hate in bad software will be met with penalty.

#### User Interface (10%)

Your product should be intuitive to use. How you accomplish this is up
to you. Good rule to stick by: If the instructor or the TA need a manual
to use your interface, your interface is bad.

#### Documentation (10%)

You must use some kind of documentation format/software, and
to provide documentation of your code. In short, you need
to use some means of documentation that can be used to generate HTML
documentation of your code. We should be able to open an HTML file to
find out all the class information such as method names, signatures, pre
and post conditions, etc.

In your GitHub repository, have a folder called `documentation` that
contains all the generated documentation, READMEs, work cited list, and
any other needed documentation.

#### Process Model (5%)

What software process model would be appropriate for this project? State
your arguments and briefly describe to what extent you have followed
this process model. Write your explanation in a text file called
`process-model.txt` and include it in the documentation folder.

#### References (5%)

This will be its own section in the documentation. Any work/code that
you or a teammate did not write from scratch, must be cited. This should
also be in your GitHub repository.

### Team Evaluations (20% of individual grade)

You will evaluate all of your teammates. You will only share the
evaluations with me and our TA. 
**The teammates you\'re evaluating will not have access to these evaluations**.
The score one received for this component is an average of all their
teammates evaluations. In other words, your teammates evaluation of you
will affect your grade for this project.
*Instructions for submitting the team evaluations will be available
after the code freeze date.*

We will likely use the [eurovision song contest](https://en.wikipedia.org/wiki/Eurovision_Song_Contest) model here.

### Self evaluations (10% of individual grade)

You will evaluate your own performance on the project. You\'ll have a
chance to list your own struggles and successes and give yourself an
overall score.

*Instructions for submitting the team evaluations will be available
after the code freeze date.*

------------------------------------------------------------------------
:::

This project was initially designed by [Dr. John
Gibbons](http://www.eecs.ku.edu/people/faculty/jwgibbo)
and 
[Dr. Alex Bardas](http://www.eecs.ku.edu/people/faculty/alexbardas).
