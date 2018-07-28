def post_url(post, has_extension: false)
  yyyy, mm, dd, *splittedTitle = File.basename(post.identifier.without_ext).split('-')
  url = "/blog/%s/%s/%s/%s/" % [yyyy, mm, dd, splittedTitle.join('-')]
  has_extension ? url + "index.html" : url
end

def slug_for(post)
  File.basename(post.identifier)
  .split('-')
  .drop(3)
  .join('-')
end

def articles
  items
  .select { |i| i.identifier.to_s.match(/posts/) }
  .sort_by { |i| i.identifier }
  .reverse()
end

def published_at(post)
  yyyy, mm, dd = File.basename(post.identifier).split('-').map{|s| s.to_i}
  Date.new(yyyy, mm, dd)
end
