# frozen_string_literal: true

def post_url(post, has_extension: false)
  yyyy, mm, dd, *splitted_title = File.basename(post.identifier.without_ext).split('-')
  url = format('/blog/%<year>s/%<month>s/%<day>s/%<title>s/', year: yyyy,
                                                              month: mm,
                                                              day: dd,
                                                              title: splitted_title.join('-'))
  has_extension ? "#{url}index.html" : url
end
