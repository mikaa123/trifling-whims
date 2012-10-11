---
title: "On class-oriented"
date: 2012-10-11 10:03
---

A few month from now, I really thought I knew what Object-Oriented programming was. Not only did I learn it from eminent professor at school, but I also practiced it, learnt all the design patterns from the GoF book and talking about java-style interfaces and abstract class was one of my favorite topic.

I’ve been diving recently into the core of Ruby and Smalltalk, not just the syntax or the object-model, but also the philosophy behind it. What’s striking is that the core concepts - or way to conceive your programs - is radically different in Smalltalk and Java.

At first, I thought the difference came mostly from dynamic typing versus static typing. So I tried to bring the two worlds together with a project called umlify that generates UML diagrams from ruby source code. This just goes to show that to me, OOP was merely a static classification and description of classes, and UML was the perfect, understandable blueprint of it.

It took me time to accept that the difference wasn’t limited to static or dynamic typing. It was hard for me to accept it, but my conception of OOP was completely false. What I was doing was Class-Oriented programming.

This article is more of a work-in-progress. I’m trying to clarify the distinction between the two seemingly related paradigm first for me, and it will certainly not be comprehensive nor always right. Just take the information and read this with a critical eye.


## Differences between Object-Oriented and Class-Oriented Programming

COP: We think in term of classes

OOP: We think about objects

### Consequences of Class-Oriented

* We tend to categorize. We care about class hierarchy.

Inheritance becomes a common pattern.

* Categorization leads to abstract classes.

They seem very useful to add more classes in a category in the future

* Not only do we categorize classes, we also categorize different method under the same name, through method-overloading.

* Polymorphism can only be achieved through inheritance.

### Problems

* Classes are static

* At run-time, the program is dynamic.

> “Object-Oriented program’s run-time structure bears little resemblance to its static code structure” - GoF 

* Classes in a hierarchy tree are tightly coupled.

A simple modification in a class hierarchy can produce unexpected ripple-effect

* Method overloading: We can’t think about all the possible use of a method at run time when programming in the large.

* A coupled source code isn’t chunkable.

Impossible to do a proper peer-review without understanding all the dependencies.

## Conclusions

* Class-Oriented works well in a “closed-universe” (i.e. programming in the small), but fails in the wild.

* We only address half of the problem with class-orientation.

* COP tend to make program more complicated and less reusable.

I think Class-Oriented programming is easier to define than Object-Oriented. If you’re wondering what is OOP, bear in mind that people are still arguing today over the proper definition. From all the research I’ve done, it seems like everybody has it’s own idea on the question.

> Actually I made up the term “object-oriented”, and I can tell you I did not have C++ in mind. - Alan Kay

Too bad Alan Kay didn’t tell us what he had in mind!

PS: I’d love to hear what you think about that. Feel free to tweet @_ms123.