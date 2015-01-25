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
