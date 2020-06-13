# frozen_string_literal: true

def post_url(post, has_extension: false)
  yyyy, mm, dd, *splittedTitle = File.basename(post.identifier.without_ext).split('-')
  url = format('/blog/%s/%s/%s/%s/', yyyy, mm, dd, splittedTitle.join('-'))
  has_extension ? url + 'index.html' : url
end
