require "date"

desc "Create post item featured by octopress"
task :new do
  now = DateTime.now
  title = "new post"
  template = <<EOS
---
layout: post
title: #{title}
date: #{now.strftime "%Y-%m-%d %H:%M:%S %z"}
created_at: #{now.strftime "%Y-%m-%d %H:%M:%S %z"}
kind: articles
comments: true
categories:
  - blog
---

Hi, I'm a new item!
EOS

  cd "content/posts" do
    filename = "#{Date.today.strftime '%Y-%m-%d'}-#{title.gsub(/ /, '-')}.md"
    open(filename, "w") do |file|
      file.write template
    end
    puts "create #{filename}"
  end
end

