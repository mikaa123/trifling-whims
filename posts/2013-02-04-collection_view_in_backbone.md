---
title: "Collection View in Backbone"
date: 2013-02-04 16:28
---

Creating a View of a Collection in Backbone is common. Yet I don't think it is a trivial thing to do. Here is how I do it.

## Motivation

A Collection's View is a very valuable tool when displaying a dynamic list of data -such as currently connected users, or a list of options- where any change in an element of the collection is directly reflected in its view.

## Diagram

![View of a Collection Diagram](/images/diagram.JPG)

## Explanation

*Collection* is the Backbone Collection we wish to create a view for.

*model* represents the models of our collection.

The models have a Backbone *view*. And so does the collection. The collection's model is *model*, since it represent the type of items we want to store.

The collection's view has an *array* of views whose type is *model*.

# Benefits

Each time the collection is changed (element added or removed), the Collection View will receive an event allowing us to re-render it. Since the view holds an array of views, it can simply ask each of the views to re-render themselves.

Since each of the element of the Collection is bound to a Model, any change to the model can be intercepted, and the view can re-render itself without any impact on the collection.
