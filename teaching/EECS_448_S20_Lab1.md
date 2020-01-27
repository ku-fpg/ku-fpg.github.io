---
layout: blank-page
title: "EECS448: Lab 1: git"
---

EECS 448, Spring 2020
---------------------

### Due Time

For this lab, you won\'t actually give us any deliverables. This lab
you\'re working locally, and next lab you\'ll push your repository
online. For grading, this is just an attendance and participation lab.

------------------------------------------------------------------------

### Lab Type

This lab is an individual lab. **NOTE**: Attendance is required for a
grade.

### Additional Resources

-   [git documentation](https://git-scm.com/documentation)
-   Online tutorials in git and github on
    [Udacity](https://www.udacity.com/course/how-to-use-git-and-github--ud775)

### Topics

Git\'s local functionalities

-   Installing git
-   Setting up the git environment
-   Creating a repository
-   Add files to staging area: status of staging area, local directory
    vs. staging area vs. commit
-   Committing: log of commits
-   Creating branches
-   Checking out commits and branches
-   Merging branches: merge conflicts

### Overview

Git is a program that allows us to do version control, meaning we can
save and track multiple versions of a single project over the course of
its development. Git is already installed on the lab machines; it is a
free piece of software available for all modern platforms.

### Git vs. GitHub

Git is a program that runs and keeps repositories on your local machine.
GitHub is an online service that utilizes git to allow people to
collaborate easily by hosting a central repository that multiple people
can fork, clone, or change as long as they have an internet connection.
This lab will focus solely on git. The next lab will discuss GitHub. In
other words, everything we do in this lab, except for a couple of steps,
can be done entirely offline.

### Exercise: Setting up git

Git is already installed on your machine, but we will do some
customizations that setup an environment conducive to using git.

#### Git config

The work you do will need to have your name and email attached to it.
Set your name and email in the git setting using the following commands:

```.shell
git config --global user.email andygill@ku.edu
git config --global user.name "Andy Gill"
git config --global core.editor nano
```                    

You can use a different text editor if you don\'t prefer nano or if nano
is not available. Of course, you should use your name and email.

#### Git and bash

Git has an lot of different options we can use and can be in several
different states. We will use some pre-made bash profiles, or in other
words, we will make bash do some handy things for us like tab-complete
git commands and tell use the status of our git repository.

##### Getting the files

1.  create and navigate, in the terminal, to a directory that will hold
    your labs. For example `~/eecs448`

2.  In a browser, go to the [instructor\'s KU GitHub page](https://github.com/ku-fpg)

3.  Navigate to the git-command-line repository

4.  Copy the clone URL

5.  Make a clone of a repository that I\'ve provided. For example,
    use the following command:

```.shell
git clone https://github.com/ku-fpg/git-command-line.git 
```

Now, you also could have just downloaded the files manually, but just
downloading doesn\'t make a git repository locally. Now you have a git
repository named git-command-line in your 448 folder. It\'s a useful
practice to use git in this way, just making repositories of files you
might need to copy to a new machine.

#### Changing the bash profile

After you make a clone of the repository, you\'ll have local copies of
three files. Two files are scripts used to aid in git commands. The
other is a .bashrc or bash profile file. **Copy these files in your home
directory** (meaning the directory you are taken to when you \"cd \~\").
If you have trouble seeing the .bashrc file, that\'s because any file or
folder preceded by a period is hidden by default. To see it, use:

```.shell
ls -a
````

### Exercise: Creating a new repository

For our lab, we will create a new repository. A repository isn\'t much
more than a directory that git tracks changes in. To create a new
repository use the command:

```.shell
git init repo-name-here 
```

Make sure [not]{.underline} to make this repository inside of your other
repository. Do this in a different folder.

### Staging area

Create a file in your new repository, call it `story.txt`. Add some text
to it. For example:

```.shell
A long time ago, in a galaxy far, far away ...
```

\"That\'s not code! Why are we doing this!?,\" you might say. Well,
remember code is just text, so we can learn how to do version control
without writing a full blown program.\
\
Creating a file is not the same as adding it to the repository. To do
that, you need to put it into the staging area:

```.shell
git add story.txt 
```

This puts the file into the staging area. Think of it like a place
between the local directory and the repository.

### Exercise: Commits and git log

To finish adding the file to the repository use:

```.shell
git commit
```

You\'ll be prompted to apply a commit message. This is meant to be a
concise description of what the commit accomplished. Here\'s a resource
for some [commit message
guidelines](https://www.git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#Commit-Guidelines).
After your first commit, you can now view that commit in the `git log`
command which lists all the commits thus far. Your log should look
similar:

```.shell
commit 509ce175885be1c8c63ac5ac91043f60538a6935 (HEAD -> master)
Author: Alex Bardas 
Fri Jan 19 10:16:43 2018 -0600

First commit message
```

*Add some text to your story* and use the following command:

```.shell
git status
```

It should look something like this:

```.shell
On branch master
Changes not staged for commit:
  (use "git add ..." to update what will be committed)
  (use "git checkout -- ..." to discard changes in working directory)

        modified:   story.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Finally, commit using `git commit` the change and run status one last
time. It\'ll look like this:

```.shell
On branch master
nothing to commit, working directory clean
```

### Steps for committing changes

In summary, for every change you want to make and commit you will do the
following:

1.  Change a file
2.  Add the changes to the staging area
3.  Commit the changes

### Commit message option

When commit-ing, you can input a flag to add a message from the command
line rather than open a text editor:

```.shell
git commit -a -m "Commit message in quotes that describes the change being committed"
```

See the descriptions of the available flags:

```.shell
git commit -h
```

### Exercise: Branches

A branch is actually just a label for the end point of a string of
commits. We are currently working with a branch, called the master
branch. The master branch, typically, is the branch that is always
working and ready to demo. But sometimes we want to add functionality or
do something experimental with the code. This is a great reason to make
a new branch.

#### Making a branch

Let\'s say I want to write a new part of the story, but since I need
some time to work on it and I don\'t want to mess up the master branch,
I will create a new branch to put my changes in. Later, I will be able
to add them back into the master branch. First, let\'s take a look at
what branches exist:

```.shell
git branch 
```

You\'ll see at least HEAD (usually it\'s a \*) and master. HEAD points
to the commit you currently have checked-out. So, currently HEAD and
master are pointing to the same commit.\
To create a branch type:

```.shell
git branch <new branch name> 
```

I\'ll name my branch solo, because I\'m going to add some text about Han
Solo.

```.shell
git branch solo
```

Now type `git branch` again and you\'ll see it added to the list.

#### Checking out a branch

To switch from the master branch to the solo branch type:

```.shell
git checkout solo
```

Now check the log:

```.shell
git log
```

You\'ll notice it\'s the same as the log from the master branch. That\'s
because we haven\'t added any commits to this new branch.

#### Exercise

1.  Write some text in story.txt
2.  Make a commit
3.  Check the log again
4.  Check out the master branch
5.  Check the log

Observe the changes. Also make note of the completely awesome fact that
**when you check out branch, the files in your local directory are
reverted to the state they were in when they were committed**.\
Does it feel like magic yet?\
If you got your bash profile setup correctly, you can see the branch you
are currently on in the terminal. You can also use `git status` to see
what branch you\'re on.

#### git diff

git diff is a tool that you can use to compare two commits. You can
compare either two branches, like your master and solo branches. You can
also compare to commits by copying and pasting in their commit ids from
the git log.

### Exercise: Merging

Merge is the last topic for this week. Merging is where you take the
changes made in one branch and try to add them to another. Let\'s merge
our solo branch into our master branch to bring the story up to date.

1.  Checkout master

2.  Type

```.shell
git merge solo
```

You\'ll see output like this:

```.shell
Updating 71d8cb7..90cb0d9
Fast-forward
  story.txt | 6 ++++++
  1 file changed, 6 insertions(+)
```

Now let\'s see how this affected the master branch. Check the log and
see what commits are now considered to be apart of the master branch. If
you\'re done with a branch, for example a branch that fixed a bug, you
can delete it after you successfully merge it. Deleting a branch only
deletes the label, not the commits associated with it. However, if you
delete all the labels then you have no way of reaching a certain branch.
Just like you can have multiple pointers refer to an object, you can
have multiple branch labels refer to the same line of commits.

```.shell
git branch -d solo
```

### Exercise: Merge Conflicts

Merging doesn\'t always go well. Sometimes two different branches
affected the same part of a file in different ways. Straight additions
are fine, and sometimes removals are fine as well, but if two branches
modify the same line(s) in different ways, then we have a merge
conflict.
Let\'s pretend we have two branches of an fake repository. On the master
branch we start with a single file, code.txt:

```.shell
int x = 5;
```

We commit this change to the master branch, create a branch called
experiment, checkout experiment, and finally make the following change
to the file:

```.shell
int x = 10;
```

That would be fine if this were the only branch to change that line,
since it is just an extension from master. Where a merge conflict arises
is if the master branch were to continue on and make changes of it\'s
own. For example, if after the experiment branch is made, we checkout
the master branch and make a change to that same line:

```.shell
int x = 70;
```

If we try to merge the experiment into the master branch, we\'ll get a
merge conflict:

```.shell
git merge experiment
```

Git is an incredible powerful tool, but there are some things it simply
cannot do. Most importantly, **git forces the user to resolve merge
conflicts manually**. And this is a good thing.\
To resolve a conflict, you simply open the file with the problem and
edit it in a way that resolves the conflict. You see notations like the
following:

```.shell
<<<<<<<<int x=70
================
int x=10;
>>>>>>>>experiment
```

Here we see what the HEAD of the master branch did to the line and what
the experiment branch did to the line. A handy property to set in git is
to use the \"diff3\" option, which will also show you what the common
ancestor, meaning the commit they both branched off from, had as it\'s
value.

```.shell
git config --global merge.conflictstyle diff3
```

Now it\'s up to you the human to decide what is best.

**CAUTION**: Git does not have any intuition, instinct, or investment in
making your project make sense, let alone work. In other words, you must
decide what\'s best. You can just delete the whole file and that can
address the merge conflict, but **just because the merge conflict gets
resolved that does not mean you did what\'s best for your project**.
Now, set up and resolve a merge conflict on your own:

1.  make a new branch
2.  checkout that branch
3.  edit a line (not just a removal or addition, but an edit)
4.  commit the change
5.  checkout master
6.  make a different change to the same line
7.  merge the branch into master
8.  resolve the conflict
9.  commit the merge

**NOTE**: If the commit message for the merge has the list of files that
caused the conflict commented out, remove the \# at the beginning of the
line. That information should be used as part of the commit message.

This lab was initially designed by 
[Dr. John Gibbons](http://www.eecs.ku.edu/people/faculty/jwgibbo),
and 
[Dr. Alex Bardas](http://www.eecs.ku.edu/people/faculty/alexbardas).

