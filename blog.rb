require 'rubygems'
require 'bundler/setup'

Bundler.require

require "rss"
require_relative "source_file"

class Blog < Sinatra::Base

  helpers do
    def title
      title = @title ? "#{@title} - " : ""
      "#{title}Trifling Whims"
    end
  end
  
  get '/' do
    haml :index
  end

  get '/archive' do
    @archives = SourceFile.archive_list
    haml :archive
  end

  get '/about' do
    haml :about
  end

  get '/posts/:id' do
    begin
      source = SourceFile.new(params[:id])
      @title = source.metadata['title']
      @content = source.content
      haml :post
    rescue Errno::ENOENT #lol i suck
      throw :halt, [404, "Not found"] 
    end
  end

  get '/puns' do
    haml :puns
  end

  get '/atom.xml' do
    archives = SourceFile.archive_data

    rss = RSS::Maker.make("atom") do |maker|
      maker.channel.author = "Michael Sokol"
      maker.channel.updated = SourceFile.last_updated
      maker.channel.title = "Trifling Whims"
      maker.channel.id = "http://www.sokolmichael.com"

      archives.each do |link, title, updated, summary|
        maker.items.new_item do |item|
          item.link = link
          item.title = title
          item.updated = updated
          item.summary = summary.gsub(/<\/?[^>]*>/, "")
        end
      end
    end
    rss.to_s
  end
end

