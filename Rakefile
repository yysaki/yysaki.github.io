# frozen_string_literal: true

require 'date'

desc 'Create post item featured by octopress'
task :new do
  now = DateTime.now
  title = 'new post'
  template = <<~TEMPLATE
    ---
    layout: post
    title: #{title}
    date: #{now.strftime '%Y-%m-%d %H:%M:%S %z'}
    created_at: #{now.strftime '%Y-%m-%d %H:%M:%S %z'}
    kind: articles
    comments: true
    categories:
      - blog
    ---

    Hi, I'm a new item!
  TEMPLATE

  cd 'content/posts' do
    filename = "#{Date.today.strftime '%Y-%m-%d'}-#{title.gsub(/ /, '-')}.md"
    File.write(filename, template)
    puts "create #{filename}"
  end
end
