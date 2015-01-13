# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
#

include Nanoc::Helpers::Rendering

unless defined? LOADED_COMPASS_CONFIG
  LOADED_COMPASS_CONFIG = true
  require 'compass'
  Compass.add_project_configuration 'config.rb'
end

sass_options = Compass.sass_engine_options

def post_url(post, has_extension: false)
  yyyy, mm, dd, *splittedTitle = File.basename(post.identifier).split('-')
  url = "/blog/%s/%s/%s/%s/" % [yyyy, mm, dd, splittedTitle.join('-')]
  has_extension ? url + "index.html" : url
end
