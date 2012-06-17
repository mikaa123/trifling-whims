class SourceFile
  attr_accessor :content
  attr_accessor :metadata
  attr_accessor :outline

  def self.archive_list
    @archive_list ||= Dir.glob("posts/*.{markdown,md}").sort.reverse.collect do |filename|
      content = File.read(filename)
      content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      title = YAML.load($1)["title"]
      [title, "/#{filename.gsub(/\..*?$/, "")}"]
    end
  end

  def self.archive_data
    @archive_data ||= Dir.glob("posts/*.md").sort.reverse.collect do |filename|
      content = File.read(filename)
      data = Metadown.render(content)

      title   = data.metadata['title']
      updated = data.metadata['date']
      summary = data.output[0..200] + '...'

      ["http://sokolmichael.com/#{filename.gsub(/\..*?$/, "")}", title, updated, summary]
    end
  end

  def self.last_updated
    filename = Dir.glob("posts/*.{markdown,md}").sort.reverse.first
    filename =~ /\/(\d\d\d\d-\d\d-\d\d)/
    Date.strptime($1).to_datetime.rfc2822
  end

  def initialize(name)
    base = "posts"
    content = ""

    content = File.read(File.join(base, "#{name}.md"))

    data = Metadown.render(content)
    self.content  = data.output
    self.metadata = data.metadata
  end
end

