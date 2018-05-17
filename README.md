Gitit-Notes
===========

[PAUSED DEVELOPMENT - 12/14/2015]

Status
------

While the use of [gitit](https://github.com/jgm/gitit) was instructive on using Haskell for something besides a trivial
program, the library itself has proved difficult for customizing leading me to hackish solutions (e.g. plugins/Icon.hs)
to create a view like I wanted. As a result, I've decided to migrate completely towards MediaWiki. Progress can be found
[online](http://joshuapotter.me/wiki/).

Resources
---------

These are the LaTeX transcriptions of various notes I maintain. I eventually plan on hosting a readonly
version on a site.

For organizational purposes, files are prefixed according to the category I've placed them in. Additionally, a 
number following the prefix refers to the book the notes were pulled from. If notes are collected from several 
books, we separate numbers with an underscore.
Books and the chapters in question are also explicitly mentioned in the LaTeX file themselves.

* Abstract Algebra
  * 01: A First Course in Abstract Algebra by John B. Fraleigh (7th Edition)
        978-0201763904
* Discrete Mathematics
  * 01: Discrete Math and Its Applications by Kenneth H. Rosen (7th Edition)
        978-0073383095
  * 02: Introductory Combinatorics by Richard A. Brualdi (5th Edition)
        978-0136020400
* Computation Theory
  * 01: Elements of the Theory of Computation by H.R. Lewis & C.H. Papadimitriou (2nd Edition)
        978-0132624787
* Functional Programming
  * 01: Learn You a Haskell for Great Good by Miran Lipovaca
        978-1593272838
  * 02: Lambda-Calculus and Combinators: An Introduction by J.R. Hindley & J.R. Seldin
        978-0521898850
* Linear Algebra
  * 01: Linear Algebra with Applications by Otto Bretscher (4th Edition)
        978-0136009269
* Multivariable Calculus
  * 01: Calculus Early Transcendentals by James Stewart (6th Edition)
        978-0-495-01166-9
* Single-Variable Calculus
  * 01: Calculus Early Transcendentals by James Stewart (6th Edition)
        978-0-495-01166-9
* Statistics & Probability
  * 01: A First Course in Probability by Sheldon Ross (8th Edition)
        978-0136033134

Installation
------------

Note wikidata is a submodule and must be pulled recursively:
```
git clone --recursive git://github.com/jrpotter/gitit-notes.git
```

Afterwards, run the following (which loads in custom plugins in the /Plugins directory):

```
cd gitit-notes
gitit -f conf/my.conf
```
