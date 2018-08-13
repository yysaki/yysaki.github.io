require "date"

deploy_default = "push"
deploy_branch  = "master"

public_dir      = "output"    # compiled site directory
source_dir      = "content"   # source file directory
deploy_dir      = "deploy"    # deploy directory (for Github pages deployment)

desc "Default deploy task"
task :deploy do
  # Check if preview posts exist, which should not be published
  if File.exists?(".preview-mode")
    puts "## Found posts in preview mode, regenerating files ..."
    File.delete(".preview-mode")
    Rake::Task[:generate].execute
  end

  Rake::Task[:copydot].invoke(source_dir, public_dir)
  Rake::Task["#{deploy_default}"].execute
end

desc "deploy public directory to github pages"
multitask :push do
  puts "## Deploying branch to Github Pages "
  puts "## Pulling any updates from Github Pages "
  cd "#{deploy_dir}" do
    system "git pull"
  end
  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }
  Rake::Task[:copydot].invoke(public_dir, deploy_dir)
  puts "\n## Copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir
  cd "#{deploy_dir}" do
    system "git add -A"
    message = "Site updated at #{Time.now.utc}"
    puts "\n## Committing: #{message}"
    system "git commit -m \"#{message}\""
    puts "\n## Pushing generated #{deploy_dir} website"
    system "git push origin #{deploy_branch}"
    puts "\n## Github Pages deploy complete"
  end
end

desc "copy dot files for deployment"
task :copydot, :source, :dest do |t, args|
  FileList["#{args.source}/**/.*"].exclude("**/.", "**/..", "**/.DS_Store", "**/._*", "**/.*.swp").each do |file|
    cp_r file, file.gsub(/#{args.source}/, "#{args.dest}") unless File.directory?(file)
  end
end

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
