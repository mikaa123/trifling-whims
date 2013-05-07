def run_bg( cmd )
  pid = Process.spawn( {}, cmd)
  Process.detach( pid )
end

desc "Make a new post"
task :new_post, :title do |t, args|
  args.with_defaults(:title => 'new-post')
  title = args.title
  date = Time.now.strftime('%Y-%m-%d')
  filename = "posts/#{date}-#{title.downcase.gsub(/\W/, "-")}.md"

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    post.puts "---"
    post.puts ""
  end
end

desc "Development server"
task :server do |t|
  run_bg( "bundle exec shotgun config.ru" )
end

desc "Sass watcher"
task :sass do |t|
  run_bg( "bundle exec sass --watch public/stylesheets/sass:public/stylesheets" )
end

desc "Live Reload"
task :guard do
  run_bg( "bundle exec guard" )
end

desc "Shotgun + LiveReload + Sass"
task :develop do
  Rake::Task["server"].invoke
  Rake::Task["sass"].invoke
  Rake::Task["guard"].invoke
end
