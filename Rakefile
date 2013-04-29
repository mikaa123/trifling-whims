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
  sh "bundle exec shotgun config.ru"
end

desc "Sass watcher"
task :sass do |t|
  sh "bundle exec sass --watch public/stylesheets/sass:public/stylesheets"
end
