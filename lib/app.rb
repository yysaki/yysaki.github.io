def post_url(post, has_extension: false)
  yyyy, mm, dd, *splittedTitle = File.basename(post.identifier).split('-')
  url = "/blog/%s/%s/%s/%s/" % [yyyy, mm, dd, splittedTitle.join('-')]
  has_extension ? url + "index.html" : url
end

def articles
  items
  .select { |i| i.identifier.match(/posts/) }
  .sort_by { |i| i.identifier }
  .reverse()
end

def published_at(post)
  yyyy, mm, dd = File.basename(post.identifier).split('-').map{|s| s.to_i}
  Date.new(yyyy, mm, dd)
end
