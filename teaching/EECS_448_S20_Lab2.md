---
layout: blank-page
title: "EECS448: Lab 2: Github"
---

### Due Time

This lab is due one week from the start of your lab session.

------------------------------------------------------------------------

### Lab Type

This lab is an individual lab. **NOTE**: Attendance is required for a
grade.

### Additional Resources

-   [git documentation](https://git-scm.com/documentation)
-   [GitHub](https://github.com/)
-   Online tutorials in git and GitHub on
    [Udacity](https://www.udacity.com/course/how-to-use-git-and-github--ud775)
-   [The Coding Train: git and github](https://www.youtube.com/watch?v=BCQHnlnPusY)

### Topics

Git\'s local functionalities

-   [cloning](https://git-scm.com/docs/git-clone)
-   forking (GitHub)
-   [pushing](https://git-scm.com/docs/git-push)
-   [pulling](https://git-scm.com/docs/git-pull)

### Overview

For this lab and for the remainder of the semester, you will be using
GitHub to host your repositories. If you haven\'t already, create a
[GitHub](https://github.com/) account. Once you have an account, don\'t
forget about the [Student Dev.
Pack](https://education.github.com/pack).
After you have an account on GitHub, you will be able to create
repositories of your own that others can access, or you can fork
existing repositories and extend on someone else\'s work.

### Cloning and Forking

#### Cloning

The act of cloning accomplishes the following:

A local copy of the repository is created:

-   You see all the files and resources in the local copy
-   You can make changes to the local copy, but these changes won\'t be
    reflected in the original repository

Creates a remote automatically (we\'ll talk more about remotes later)

Things that cloning does __NOT__ do:

-   Alter the original repository
-   Give you control over the original repository in any way

#### Forking

In this lab you will fork a project called
[lab02](https://github.com/ku-fpg/eecs448-lab02). Forking a project
creates a clone of the original repository on GitHub.
Things forking does not do:

-   Forking does not create a local copy of the repository, but you can
    still clone your fork of the project
-   Give you control or alter the original project in any way

#### Forking vs. Cloning

First of all, forking is entirely a GitHub (not git) creation; there is
no \"fork\" command in git. Forking is very convenient and useful
because you can then clone or link people to the repository that you
forked. In short, a fork is just a clone of a repository that GitHub
stores for you. 
You have total control over your fork or clone of a repository, but you
never have control over the original without permission.

### Exercise: Creating a Repository on Github

Last lab, you made a repository that you wrote a story in. This was not
created or cloned from GitHub - it was entirely local. To post this
repository on GitHub, do the following:

In a web browser:

1.  Navigate to GitHub
2.  Select the plus icon near your profile picture and select \"create
    new repository\"
3.  Name the repository the same as your local one
4.  Make note of the \"https\" URL

#### Remotes

Here is the situation:

-   We have a local repository with our story in it
-   We have an empty repository on GitHub

Our goal: copy the local repository to GitHub for the world to see.
Here\'s what to do:

In your local repository add a remote to your repository:

    git remote add <name> <url>

Example:

    git remote add origin https://github.com/andygill/story.git

Notes:

-   Origin is a naming convention to refer to the GitHub remote
-   The URL will end in `.git`
-   You can obtain the URL from GitHub
-   Adding a remote simply adds a remote label to git, we still need to
    copy our repository to GitHub

#### Pushing

We have just added a remote to our repository. Now we will **push** our
changes repository - to GitHub.

    git push <remote> <branch>

Example

    git push origin master

At this point, you\'ll be prompted to provide your GitHub credentials.
If you asked to interact with SSHPASS, you can just close the prompts
that pop up. After you give your credentials, your repository will be
copied to GitHub.

After you push your local branch, go back to GitHub to see your
changes.  Note that push is NOT the same as cloning from your local
repository to GitHub. Cloning implies the copying of an entire
repository. When you push, you push a single branch. There is a way to
push all your branches, but I only recommend doing that if you are
adding some pre-existing repository to GitHub for the very first
time. All other pushes should be a single branch. (Further reading on
push: [Git documentation](https://git-scm.com/docs/git-push)).

### Exercise: Forking

Navigate to the [lab02](https://github.com/ku-fpg/eecs448-lab02) repo

Create a fork of the [lab02](https://github.com/ku-fpg/eecs448-lab02)
project by clicking the fork button in the upper right corner

Navigate back to you profile page

-   You should see a listing for the lab02 repo under your profile now.

What just happened? You created a fork of an existing GitHub repository.
Again, forking is an GitHub idea - nothing has changed on your local
machine. Essentially, you cloned my repository but the clone is being
housed on GitHub instead of your local machine.

What do now:

-   On your local machine: Make a clone of your fork and use the URL
    from the fork of your repository, not mine.

Okay, now you have a local copy of your fork of my repository. Now you
can work and make changes to the local copy and push them to your fork.
If you and I were collaborating, you could make changes then create a
pull request for me, which would allow me to review and accept the
changes you had made on your fork.

For the purposes of this lab, you simply modify your fork of the
repository.

Exercise:

-   In your local repository, create working method definitions for all
    Linked List methods that currently have dummy returns (look for TODO
    notes in the LinkedList.hpp)
-   Create series of commits that represent logical changes to the code
    until you have a working version of the LinkedList class
-   Use the provided test code to verify your changes work
-   After you have it working locally, push your master branch to your
    fork

### What to submit

Email your TA a link to your GitHub profile. Follow the submission
instructions below.

### Rubric

\[25pts\] Story Repository

-   \[10pts\] Contains a current Story.txt
-   \[15pts\] master log contains a commit history representative of lab
    01

\[70pts\] Linked List Repository

\[30pts\] The score produced by the Test Suite

-   To get all 30pts, the Test Suite score must be 100
-   A Test Suite Score of 50pts would result in you getting 15pts for
    this section of the lab

\[40pts\] Commit history

-   Each commit represents a single logical change (e.g. You should NOT
    just have 1 commit that reads \"Implement all the methods. Done\"
-   At a minimum, you should have a commit per method definition
-   If you add or change any existing member methods or variables, that
    should be noted in a commit
-   Commits are descriptive and written in the imperative tense

\[5pts\] Email Subject line matches requirements

Only repositories available through your GitHub profile will be
considered for a grade.

If you want to make your repo private, you will need to add
your instructor and your TA as collaborators. Instructor\'s
and TA\'s GitHub usernames are:

  * andygill
  * sushmitha4-cloud

### Submission Format

-   Email Subject lines: `EECS448 LastName FirstName StudentID Lab##`
    (replace \#\# with the appropriate lab number)
-   If a tarball is attached, format the file name of the tarball as
    follows: `EECS448-LastName-FirstName-StudentID-Lab##.tar.gz`

This lab __does not__ have a tarball component.

This lab was initially designed by 
[Dr. John Gibbons](http://www.eecs.ku.edu/people/faculty/jwgibbo),
and 
[Dr. Alex Bardas](http://www.eecs.ku.edu/people/faculty/alexbardas).


