---
layout: post
title: "Things to learn from functional programming"
date: 2012-01-31 10:12
comments: true
categories: 
---

Functional programming and Object-Oriented (imperative) style share lots
of common features. Having spent time exploring functional programming
recently, here is what I think we can learn from it to improve our
Object-Oriented programs.

<!-- more -->

### On the paradigm level

The two paradigms share common idioms. The notion of _function_ sounds a
little like the notion of _method_, in that it describes a stand-alone
computational block.

In its form, it also looks similar. Functions have names, and can take
argument. They also return something.

However, the similarities stop here.

### Pureness, or how to be more deterministic

Functions are ideally pure, which means their return value will always
be the same given fixed inputs. Functions don't have _side effects_.

* Tracking bugs in an Object-Oriented code-base where methods
  inconsistently change state is difficult.

* Methods with side-effects should be clearly identified, and possibly
  kept to a minimum.

### Single Responsibility Principle

This principle is general enough to be applied whenever possible. It is
however crucial in functional programming because of the deterministic
nature of a function.

Each function has a clear, often atomic purpose. Other functions then
build upon these functions.

* If a method doesn't do one thing, and one thing only, break it down.

* If a method is complex, then it would be advisable to create other
  methods that take care of parts of the complexity.

* Doing so DRYs up the code-base.

Because of Pureness and Single Responsibility Principle, it's not rare
to see complex functions expressed in one line.

### Edge cases and recursion, so meta!

Recursion is a big thing in functional programming, as it is in math.
When dealing with functions, it feels natural to use it, a lot more than
when using imperative languages.

When done correctly, recursion increase a lot readability and avoids
using cumbersome control structures such as loops.

To define a function recursively, it is first needed to identify the
_edge cases_. Those are the boundary conditions. Since this is so common
in functional programming, languages such as Haskell even give some
syntactic construct for that.

* When defining a method, try to first think about the edge cases. Not
  only will it help you with your tests, it's going to make your system
more robust. Only then describe the general case.

* Use recursion whenever possible.

### Higher-Order functions

The functional programming derives from _Lambda calculus_, a
computational system which, when summed-up roughly, says that we don't
really care about the name of a function, nor do we care about the name
of its parameters, and that in the end we only care about what it does.
Thus, it introduces what is called _lambdas_, anonymous functions.

Since a function always returns a value, nothing prevent it from
being assigned to a variable, passed as a parameter, or even returned
from another function (a higher-order function).

* Lambdas are great when you need to define a trivial, transactional
  process such as a filter. Use it if your language allows it!

* Meta programming, much? Functions that take functions as arguments and
  return functions. Code that generates code. First-class functions
makes it so much easier. 

### Currying. Or awesomeness.

Currying is one of my favorite thing about functional programming. It
makes the whole system very elegant and simple.

A function takes _only one_ parameter. Yes, you heard me right. Still,
it's possible to define functions that take multiple arguments
(thankfully). This is possible through to what's called _currying_.

Currying is the act of transforming a function that takes multiple
arguments into a chain of functions that each take a single parameters.

Ok, this might not seem really exciting. But currying brings with it
something else, _partially applied functions_.

Think about it. If you need to curry a function that takes two
parameters, say A and B. You need to chain a method that takes A, and a
method that takes B. The method that takes A has to return a method that
already fixed the A parameter. It's a _partially applied function_.

Partially applied functions are functions. They can be constructed on
the fly using pre-existing functions. They can be assigned to variable
or passed around. You'll soon see what's great about it.

* Have a method that has lots of parameters? Can some of these
  parameters be fixed for a given use-case? If so, playing around with
partially applied method can improve a great deal the DRYness of your
code.

While writing this post, I played around with Ruby and created a gem for
making it easy to create and use partially applied methods. Check it
[there](https://github.com/mikaa123/Curby) if your are interested.

### Forget about loops

Looping is a common idiom in imperative programming. We use it a lot,
in fact, we probably use it too much. The problem with loops is that we
force the computer to do it. Sometimes, that's great. But sometimes, it
can lead to optimisation problems. How about leaving the optimisation
problems to your computer and just focus on what needs to be done?

Functional programming don't have loops. It instead uses lists and
filters.

Thanks to higher-order functions (functions that take functions as
input, or output functions) and lambdas, it's possible to define
functions that iterate over a collection.

If you are using a language like Ruby, chances are that you never use
"for" or "while" loops either. In fact, you are probably already using
functional programming style without knowing it.

* each, map, inject (reduce) functions are taken from the functional
  paradigm

* How about using these methods with partially applied lambdas? Big win!

## Reflections

What's nice when exploring paradigms is realizing that there's not only
one way to write code, or to think about code. It's a little like
traveling or trying out new food. Sometimes, you don't really like
it. Sometimes, you like it so much that you feel what you saw
before is tasteless.

Object-Oriented is my way to go. I like how it maps the real world, how
it's instinctive. That's how I like defining my solutions. Yet, having
seen functional programming made me realize that I can apply some of the
things I really liked.

To me, what's important is both expressiveness and readability. I believe that
the things I talked about in this post increase both.
