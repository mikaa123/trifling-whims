---
title: "MVCP - Better Separation of Concern"
date: 2012-01-14 12:49
---

A good architecture is all about eliminating dependencies and increasing reusability. Rails provides a baked-in support for the model-view-controller paradigm, which helps quite a bit in most cases, but has some bleeding edges.

In this post I'll explain how a simple new component, the Presenter, can help a great deal in increasing the Separation of Concern in your web applications.

Before going further, I'd like to point out to some very good articles that talks about the Presenter pattern in Rails. Steve Klabnik, one of my favorite Rubyist talks about it in his post ["The Secret to Rails OO Design"](http://blog.steveklabnik.com/posts/2011-09-06-the-secret-to-rails-oo-design), and on ["Better Ruby Presenters"](http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters). I'd really encourage you to read them if you are interested by the subject.

Before talking about Presenters and how they fit into the whole MVC-esque picture, let's take a step back and talk about what they are, how they work, and what their purpose is.

## Presenters, what are they?

A presenter is an object that *encapsulates the presentation logic* of a response. It offers a protocol (or an interface, same thing) to communicate directly with your views. Thus, your views don't have any logic, and your controllers only focus on business processes. It's the presenter's job to compute the controller's output and to transform it into an object that complies with the view's requirements.

### An example use-case

Here is an example I recently had. Suppose your application has to deal with Reporting. Specifically, displaying reports.

In your models, you'd have something like that:

    class Report
    
    	attr_reader :positive_feedback, :improvement_feedback
    		
    	def initialize
         @positive_feedback = []
         @improvement_feedback = []
       end
    end

In your `summary` view, you'd like to display a summary of all the reports. Specifically, you'd like to display a list of all the `positive feedback`, and a list of all the `improvement_feedback`.

Your controller might look something similar than that:

    class ReportsController < ApplicationController
    	
    	def summary
    		@reports = Reports.all
    		@total_reports = Reports.count
    	end
    end

Straightforward, right? Now the view.

    <h1>Positive feedback</h1>
    <ul>
    <% @reports.each do |report| %>
    	<% @report.positive_feedback.each do |feedback| %>
    		<li><%= render feedback %></li>
    	<% end %>
    <% end %>
    </ul>
    
    <h1>Improvement feedback</h1>
    <ul>
    <% @reports.each do |report| %>
    	<% @report.improvement_feedback.each do |feedback| %>
    		<li><%= render feedback %></li>
    	<% end %>
    <% end %>
    </ul>
    
    <p>Reports processed: <%= total_reports %></p>

This isn't too bad, however, there are a couple things that could be done better. For a starter, we could DRY things up a little using some renderer's magic.

    <h1>Positive feedback</h1>
    <ul
    <% @reports.each do |report| %>
    	<%= render report.positive_feedback %>
    <% end %>
    </ul>
    
    <h1>Improvement feedback</h1>
    <ul>
    <% @reports.each do |report| %>
    	<%= render report.improvement_feedback %>
    <% end %>
    </ul>
    
    <p>Reports processed: <%= total_reports %></p>

Great, that's a lot simpler. But let's take it a step further.

    <h1>Positive feedback</h1>
    <%= render @reports, :locals => {:feedback => :positive} %>
    
    <h1>Improvement feedback</h1>
    <%= render @reports, :locals => {:feedback => :improvement} %>
    
    <p>Reports processed: <%= total_reports %></p>

Compared to the first version, this view is much easier to understand. But in order to make it, we had to introduce some logic in our views (through the locals passed to the partial). As a rule of thumb, seing any sort of logic in a view (even on as simple as this), should raise a flag in your head. Views should not have logic.

To address this issue, we are going to use a Presenter. It will also help us correct another Separation Of Concern problem introduced in the controller, which was:

    class ReportsController < ApplicationController
    	
    	def summary
    		@reports = Reports.all
    		@total_reports = Reports.count
    	end
    end

The @total_reports variable's value is nothing but a display artifact that isn't a core business process of our application. Thus, it's not the Controller's job to calculate it.

There's a clear pattern here. In the view, we saw that the logic has no place to live. In the controller, we saw that the view's logic isn't any of its concern. So where do we put them? You guessed, in the Presenter.

    class ReportsPresenter < ApplicationController
    	
    	def initialize reports
    		@reports = reports
    	end
    	
    	def count; @reports.count; end
    	
      # Returns an array with all the positive feedback
      def positive_feedback
        @reports.inject([]) do |feedback_collection, report|
          report.positive_feedback.each { |feedback| feedback_collection << feedback }
          feedback_collection
        end
      end
      
      # All the improvement feedback
      def improvement_feedback
        @reports.inject([]) do |feedback_collection, report|
          report.improvement_feedback.each { |feedback| feedback_collection << feedback }
          feedback_collection
        end
      end
    end

Et voilà!

Now let's change the controller and the view accordingly.

    class ReportsController < ApplicationController
    	
    	def summary
    		@reports = ReportsPresenter.new( Reports.all )
    	end
    end


    <h1>Positive feedback</h1>
    <ul><%= render @reports.each_positive_feedback %></ul>
    
    <h1>Improvement feedback</h1>
    <ul><%= render @reports.each_improvement_feedback %></ul>
    
    <p>Reports processed: <%= reports.count %></p>

Your view is now logicless, and your controllers don't delegate to the Presenter to take care of the presentational logic.

## Presenter, as a design pattern

A presenter is a special case of the ["Decorator design pattern"](http://en.wikipedia.org/wiki/Decorator_pattern). A decorator is exactly what its name implies it to be: an object that *decorates* another object. If you forgot what it is, just take your GOF book from that shelf and open it at page 175.

Decorator's main goal is to add behavior to another object during runtime. Thus, a decorated object *is* what it originatly was, plus a number of other methods. Liskov substitution applies. In the example I showed above, the Presenter wasn't exhibiting all the behavior an array usually has, thus many people simply use _method_missing_ to dispatch unknown method to the decorated object when they use the decorator pattern in Ruby.

## Reflections

Presenters are a great way to increase the Separation of Concern of your applications without adding complexity. For the same object, you can have several Presenters, depending on the different views.

Another benefit is when it comes to testing. Testing views can take a long time since it often requires starting up rails. If you only test your Presenters, your test suit's speed can increase by an order of magnitude!

 

