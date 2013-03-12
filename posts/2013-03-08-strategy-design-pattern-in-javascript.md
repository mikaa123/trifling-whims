---
title: "Strategy Design Pattern in Javascript"
date: 2013-03-08 18:20
---

I love the __Strategy__ design pattern. I try to use it as much as I can. In its essence, the Strategy pattern uses delegation to decouple algorithms from the classes that use them.

There are a few benefits to this. It prevents using big conditionals to decide which algorithm to use for the given type of object. It separates concerns, thus reducing the complexity of the clients and it promotes composition over subclassing. It improves  modularity and testability. Each algorithm can be tested in isolation. Each client can mock an algorithm. Any client can use any algorithm. They can be swapped. Just like lego blocks.

To implement Strategy, there are usually two participants:

__The Strategy__ an object that encapsulates an algorithm.

__The Client__ (or Context) an object that can use any Strategy, in a plug-and-play manner.

Here is how I use the Strategy pattern in Javascript, and how it is used in the wild to break libraries into small, plug-and-play packages.

## Strategy as a function

A function provides a great way to encapsulate an algorithm and can be used as a Strategy. Simply pass a function to the Client and make sure your client calls the Strategy.

Let's illustrate this with an example. Say we want to create a Greeter class. What it does is greet people. We want our Greeter class to know different ways of greeting people. In order to do that, we will create different Strategies to say hello.

<script src="https://gist.github.com/mikaa123/5117532.js"></script>

In the example above, Greeter is the Client, and there are three Strategies. As you saw, Greeter knows how to use an algorithm, but have no idea about the algorithm specifics.

For complex algorithms, a simple function is often not enough. In this case, it's better to define it in terms of objects.

## Strategy as a class

Strategies can also be classes, especially when the algorithm is more complex than the contrived one used in the above example. Using classes allows you to define an interface for each of your Strategies.

This is what I did in the next example.

<script src="https://gist.github.com/mikaa123/5117932.js"></script>

By using a class, we defined a Strategy as an Object with an `execute` method. The client can use any Strategy that comply to that interface.

Notice how I also created a `GreetingStrategy`. The interesting part is in the overriden method `execute`. It is defined in term of other functions. Now subsequent children of that class can change specific behaviors, such as the `sayHi` or `sayBye` method, without altering the general algorithm. That pattern is called the __Template Method__ and works great with the Strategy pattern.

Let's see how.

<script src="https://gist.github.com/mikaa123/5117993.js"></script>

The GreetingStrategy created a category of algorithms by specifying the steps of the `execute` method. In the above snippet, we took advantage of that by creating specialization of that algorithm.

Without using subclasses, our Greeter still exhibits a polymorphic behavior. There is no need to switch on the type of the Greeter to trigger the correct algorithm. It's all baked into each Greeter object.

<script src="https://gist.github.com/mikaa123/5118094.js"></script>

## Strategy in the wild

One of my favorite example of Strategy pattern is in the [Passport.js](http://github.com/jaredhanson/passport) library.

Passport.js provides a simple way to handle authentication in Node. It supports a wide range of providers (Facebook, Twitter, Google, etc.) each implemented as a Strategy.

The library is available as an npm package, and so are all its Strategies. The user of the library can decide which npm package to install for his particular use case. Here is a code snippet that shows how it works:

<script src="https://gist.github.com/mikaa123/5135712.js"></script>

The Passport.js library only comes with a couple of simple authentication mechanisms. Other than that, it's nothing more than a Context Object that complies to the interface of a Strategy class. This architecture makes it easy for people to implement their own authentication mechanism without cluttering the project.

## Reflection

Strategy provides a way to increase modularity and testability for your code. This doesn't mean it should always be used. Mixins can also be used to inject functionality, such as an algorithm, to an object at run-time. Plain old duck-typing polymorphism might sometime be simple enough too.

However, using Strategy allows you to scale your code as the complexity grows without introducing a big architectural overhead in the first place. As we saw in the Passport.js example, it makes it more convinient for maintainers to add another Strategy in the future.
