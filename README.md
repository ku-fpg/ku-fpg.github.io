Webpages for the KU FPG
=======================

## Adding files

 * To add a file, add a .md file, in the appropriate directory.

 * To edit the sidebar, edit _data/sidebar.html

 * To edit the navbar, edit _data/navbar.html

## Building

 * To build, use `echo :main build | cabal repl`.
   There are a number of .md files that are auto generated.

   * _meta/bibtex.bib => _data/publications.yml & papers/*md

 * To generate the html files into _site, use `jekyll build`.

 * To generate the html files into _site, and preview them in
   your browser, use `jekyll serve`.

## Other Packages

Here are a list of files we've included from other sources

bootstrap-3.2.0:

    css/bootstrap-theme.css
    css/bootstrap-theme.css.map
    css/bootstrap-theme.min.css
    css/bootstrap.css
    css/bootstrap.css.map
    css/bootstrap.min.css
    fonts/glyphicons-halflings-regular.eot
    fonts/glyphicons-halflings-regular.svg
    fonts/glyphicons-halflings-regular.ttf
    fonts/glyphicons-halflings-regular.woff
    js/bootstrap.js
    js/bootstrap.min.js

jquery-1.11.1:

    js/jquery-1.11.1.min.js











