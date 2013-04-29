# Installing
To install run `bundle install`

# Running
It's a Sinatra app, so `rackup` to start it.

## Shotgun
You can use shotgun to reload the server upon each request. It's packaged in the Gemfile under development.

    shotgun config.ru

## Sass
I use sass. To compile, 

    bundle exec sass --watch public/stylesheets/sass:public/slesheets

## LiveReload
Optionally, to have the page reloading each time something changed in the CSS,

    bundle exec guard
