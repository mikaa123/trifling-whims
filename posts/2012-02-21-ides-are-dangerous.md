---
title: "IDEs are dangerous"
date: 2012-02-21 14:03
---
Integrated Development Environments are supposed to help developers work faster. They
are designed to increase productivity by providing a set of tools to
work with a language. Often, they integrate the field's best
practices when it comes to source files organisation or debugging.
Features like auto-completion or code refactoring are attractive. Compared
to the seemingly terseness of the terminal and text editors such as Emacs
or Vim, IDEs seem just right.

Yet more and more users are switching from IDEs back to Emacs or
Vim. From GUI to terminal. Even a whole lot of Textmate users decided to
move out of it. Why is that?

<!-- more -->

In this post, I'll explain why I think most mainstream IDEs are harmful in the long run for
developers and companies and why I think we should move away from them.
First, I'll talk about IDEs' problem with the environment,
specifically with other programs and tools. Then with working with other
people. After that, I'll talk about the bad working habits they can
generate.

## IDEs and the environment
When you use UNIX, you expect your tools to sort of work together in
perfect harmony. Since UNIX programs output streams of text, it's easy to feed the output of a
program as an input to another one. However, using GUIs, you can't
really pipeline. IDEs are no exception to that.

### IDEs don't play nice with others
What if you need to export some output of the IDE to another software? What if you need to fill an Excel
sheet with the results of a functional testing of your software.
Plugins! I hear you say. Yes, but what if none fit your needs? What if there
is a perfect tool to help you out, yet you can't get the IDE to
communicate with it? _The fact that IDEs use a GUI makes the communication between them and other programs
complicated._

### IDEs are often tied to a language
While this isn't always true, IDEs tend to be created to support one
language. In this case, the choice of the technology defines the
environment for the developer. Changing the tool set from a project to
another lowers developer's productivity and adds a learning overhead. While it is possible to code C# in
Eclipse, it is more advisable to use Microsoft's Visual Studio. Your
team's development process is tied to the tools, and improving it can be
hard when such a central piece can be so volatile.

### IDEs are often tied to a company
Talking about the benefits of Open-Source and Libre softwares would be a
post (even a blog!) of its own. Instead, I'd like to point out that companies invest a
lot of money in IDEs, which mean that they have a lot of deciding power
in which language, tools, or process to push forward. Keep in mind that
their decisions often reflect an economical motivation and bias.

### Big, heavyweight, complex
In order to fill a majority of use-cases and requirements, IDEs grow
heavy. Not everyone need all their features for every projects. This in
turns clutters the interface and goes against the simplicity they
advertise.

## Problem working with other people
IDEs should make working with other people easy. And it does... Unless
you don't have the exact same version of the IDE. _Dependency management
should be at the core of the IDE's feature list_. If you've ever worked
with systems like [RVM](http://beginrescueend.com/) for Ruby and [Bundler](http://gembundler.com/), then you know that there's
no need to carry a box of aspirin in your bag when you are checking-out
someone's project.

### Project Files
IDEs tend to add a whole lot of meta-information on your project that
nobody really cares about. It makes it really hard to work with anybody
else that isn't using exactly the same IDE (and version) as you are. It
also adds up in your repository if you don't put them in the ignore list
of your VCS. Which brings me to the next point.

### The whole team should use the same IDE
And so does everybody working on your project. It's not about code
anymore, it's about "project files", "solutions", and thousands of
configuration files.

### IDEs change fast
Ever had any compatibility issues when upgrading an IDE? Then you know
what I mean.

## IDEs and work flow
While common work flows are simple to achieve using an IDE, the lack of
flexibility gets in your way whenever you do something differently. I'm
talking BDD, TDD, using a ticketing system, a CI server, or anything
else.

### Mainstream IDEs aren't designed for dynamic languages
As pointed out by
[this](http://programmers.stackexchange.com/questions/131561/ides-for-dynamic-languages-how-far-can-you-get),
most IDEs are inspired from what has been done in Smalltalk, which is a
dynamic language. Smalltalk IDE provides auto-complete, refactoring, and a lot of code analysis tools. Note that
the approach used by Smalltalk is different from the one used by other
IDEs. I still have to find an IDE that does a good job with dynamic
languages other than Smalltalk's.

For more in-depth information on dynamic languages and IDEs, check out
[Steve Yegge's talk](http://www.youtube.com/watch?v=tz-Bb-D6teE) at Stanford University.

#### Auto-completion
Most code features of IDEs take advantage of static typing. A dynamic
language, due to its nature, can be harder to predict prior to runtime.
Not impossible, though.

#### Refactoring
In dynamic languages, classes (given the language use them) are
decoupled. This introduce a great deal of flexibility, but also means
that the tools used to refactor statically typed code are different.

# Bad habits
On top of that, IDE can induce bad habits for the developer.

### They tighten your solutions to what's in the menus
There's no place for creativity. Each problem has its own way of getting
solved, and if not, then too bad. When we need something, i.e. export
some code to UML, we passively browse the menus to find the feature.

### IDEs increase passivity
Instead of doing what we think, we do whatever the IDE allows us to.
This creates bad habits, such as relying on auto-complete. _Instead of
being a direct actor, we become some sort of operator of a big machine
that does the work for us._

# Reflections
In my opinion, IDE's goal of simplifying common work flows by packaging
tools and processes reduces flexibility. It narrows down creativity.
The cognitive-overload introduced by the GUI distracts us from thinking
about what problem we need to solve. It increases passivity and leads to
bad habits.

Yes, it's easy to use, it streamlines development, but at which cost? An
ubiquitous IDE? Configuration-driven project files? A monolithic block
whose tools and process you have to use and follow, even though you want
to use different ones?

So what? Shall we kill IDEs? Open-up text editors and get rollin'? Well,
not really. I think what we need to do is use the right tool for the
job. In this case, UNIX is probably the best IDE out there. It lies
right beneath our eyes, waiting for us to use it. Yes, its interface
isn't as colorful as Eclipse (although it does have a retro-look), but
its simple philosophy has proven strong enough to stand the test of
time.

## Some relevant links
* Unix as an IDE: <http://blog.sanctum.geek.nz/series/unix-as-ide/>
* The Art of Unix Programming: <http://catb.org/~esr/writings/taoup/>
* Steve Yegge's talk on dynamic languages at Stanford: <http://www.youtube.com/watch?v=tz-Bb-D6teE>
* Bret Victor talks about direct feedback in GUIs: <http://vimeo.com/36579366>

