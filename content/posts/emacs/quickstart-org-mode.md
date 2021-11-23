+++
title = "Org-mode quickstart tutorial"
author = ["Xing Wenju"]
date = 2021-11-22T00:00:00-04:00
draft = false
+++

[en](https://orgmode.org/index.html "English version") 

[fr](https://orgmode.org/fr/index.html "Version française") 

[ja](https://orgmode.org/ja/index.html "Japanese version") 

[![](https://orgmode.org/resources/img/org-mode-unicorn.svg) Org Mode](https://orgmode.org/index.html)
 
[Features](https://orgmode.org/features.html) 

[Releases](https://orgmode.org/Changes.html) 

[Updates](https://updates.orgmode.org/) 
 
[Install](https://orgmode.org/org.html#Installation) 
 
[Manual](https://orgmode.org/manual) 
 
[Worg](https://orgmode.org/worg) 
 
[Contribute](https://orgmode.org/worg/org-contribute.html)


Getting started with Org-mode
-----------------------------

In its simplest form, Org is like any other markup language.

You can write [Org syntax](https://orgmode.org/worg/dev/org-syntax.html) in any text editor.

However, to experience the full potential of Org you need an editor that transforms Org syntax into a living, interactive document.

Preamble
--------

At the start of a file (before the first heading), it is common to set the title, author and other [export options](https://orgmode.org/manual/Export-Settings.html).

```
#+title: The glories of Org
#+author: A. Org Writer

```

Heading
-------

Lines that start with an asterisk `*` are [headings](https://orgmode.org/worg/dev/org-syntax.html#Headlines_and_Sections).

A single `*` denotes a 1st-level heading, `**` denotes a 2nd-level heading, etc.

```
\* Welcome to Org-mode
\*\* Sub-heading
Each extra ~\*~ increases the depth by one level.

```

In their simplest form headings are just the start of a section. However, any heading can also become a [TODO item](https://orgmode.org/manual/TODO-Items.html).

TODO items are the basic building block that Org uses to track and organize all kinds of tasks.

To add a TODO item to a heading, start the heading with a TODO keyword such as `TODO` or `HOLD`.

```
\* TODO Promulgate Org to the world
\*\* TODO Create a quickstart guide

```

Markup
------

To mark up text in Org, simply surround it with one or more marker characters. **Bold**, _italic_ and underline are fairly intuitive, and the ability to use ~strikethrough~ is a plus. You can _**combine**_ the basic markup in any order, however `code` and `verbatim` need to be the **`inner-most`** markers if they are present since their contents are interpreted `_literally_`.

```
To markup text in Org, simply surround it with one or more marker characters.
\*Bold\*, /italic/ and \_underline\_ are fairly intuitive, and the ability to use
+strikethrough+ is a plus.  You can \_/\*combine\*/\_ the basic markup in any
order, however ~code~ and =verbatim= need to be the \*\_~inner-most~\_\* markers
if they are present since their contents are interpreted =\_literally\_=.

```

See [Emphasis Markers](https://orgmode.org/worg/dev/org-syntax.html#Emphasis_Markers) for more details.

Lists
-----

Unordered lists start with `+`, `-`, or `*`[1](#fn.1). Ordered lists start with `1.`, `1)`, `A.`, or `A)`. Ordered and unordered bullets can be nested in any order.

```
To buy:
1. Milk
2. Eggs
   - Organic
3. Cheese
   + Parmesan
   + Mozzarella

```

Lists can contain checkboxes `[ ]`, `[-]`, `[X]`.

```
\- \[ \] not started
- \[-\] in progress
- \[X\] complete

```

Lists can contain tags (and checkboxes at the same time).

```
\- \[ \] fruits :: get apples
- \[X\] veggies :: get carrots

```

Links
-----

To create a link put the target between two square brackets, like so: `[[target]]`. You can include a description in square brackets after the target `[[target][desc]]`.

The order is easy to remember because it is the same as an html `<a>` tag `<a href="target">desc</a>` and you can't mix up brackets and parentheses because there are only square brackets!

Org supports a wide variety of types of link targets, and you can also [add your own](https://orgmode.org/manual/Adding-Hyperlink-Types.html). Link types are indicated with a `type:` prefix, i.e., `[type:target]`. If no `type:` is provided, org searches the current file for a heading that matches `target`.

Some examples:

```
\[\[https://orgmode.org\]\[a nice website\]\]
\[\[file:~/Pictures/dank-meme.png\]\]
\[\[earlier heading\]\[an earlier heading in the document\]\]

```

Images
------

Org mode automatically recognizes and renders image links during export. Just link to an image (don't include a description). That's it.  
`[[https://upload.wikimedia.org/wikipedia/commons/5/5d/Konigsberg_bridges.png]]`

![](https://upload.wikimedia.org/wikipedia/commons/5/5d/Konigsberg_bridges.png)

Images located on your computer can also be rendered in the Emacs buffer with `C-c C-x C-v`.

Blocks
------

Org mode uses `#+BEGIN` … `#+END` blocks for many purposes. Some of the basic blocks types quote, example, and src.

If you all you need is monospace text, you can use an example block.

```
#+begin\_example
monospace
#+end\_example

```

However, example blocks do not give you the power of [Org babel](https://orgmode.org/worg/org-contrib/babel/). For that you need a source block. Source blocks provide syntax highlighting, code execution, literate programming, and more.

```
#+begin\_src emacs-lisp
(message "Hello world")
#+end\_src

```

# More info

A hello world example cannot even begin to scratch the surface Org mode's support for [working with source code](https://orgmode.org/manual/Working-with-Source-Code.html).

Tables
------

Org mode comes with a table editor complete with support cell references and formulas.

In its simplest form a table is text separated using pipes `|`.

```
| I    | am  | a    | table |
| with | two | rows | !     |

```

A more useful example is this comparison of existing Literate programming / reproducible research tools (from [Schulte _et al._ 2012](https://doi.org/10.18637/jss.v046.i03)).

```
| Tool         | Literate programming? | Reproducible Research? | Languages |
|--------------+-----------------------+------------------------+-----------|
| Javadoc      | partial               | no                     | Java      |
| Haskell .lhs | partial               | no                     | Haskell   |
| noweb        | yes                   | no                     | any       |
| Sweave       | partial               | yes                    | R         |
| Org-mode     | yes                   | yes                    | any       |

```

Worried about aligning free text tables? Org mode does it in a single keystroke – `tab`.

Macros
------

Org has many more advanced features built into its syntax. To give only a single example, let's take a look at [macros](https://orgmode.org/manual/Macro-Replacement.html).

```
#+macro: attn \_\*/$1/\*\_
{{{attn(Attention! This text gets all the markup!)}}}

#+html\_head: <style>.red{color:red;}</style>
#+latex\_header: \\usepackage{xcolor}
#+macro: red @@html:<span class="red">$1</span>@@@@latex:\\textcolor{red}{$1}@@
Regular text. {{{red(This text will be red.)}}} More regular text.

```

Next steps
----------

Looking for something in particular? The [manual](https://orgmode.org/manual/) ([PDF](https://orgmode.org/org.pdf)) is a good place to start.

Looking for something between this quickstart and the manual? The [guide](https://orgmode.org/guide/) ([PDF](https://orgmode.org/orgguide.pdf)) is worth a shot.

licensed under the [GNU FDL 1.3](https://git.sr.ht/~bzg/orgweb/blob/master/LICENSE.org "GNU Free Documentation License version 1.3")
