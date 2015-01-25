def post_url(post, has_extension: false)
  yyyy, mm, dd, *splittedTitle = File.basename(post.identifier).split('-')
  url = "/blog/%s/%s/%s/%s/" % [yyyy, mm, dd, splittedTitle.join('-')]
  has_extension ? url + "index.html" : url
end
