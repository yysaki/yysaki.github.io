# Require any additional compass plugins here.
add_import_path "bower_components/foundation/scss"

# -----------------------------------------------
# Paths
# -----------------------------------------------

http_path = "/"
css_dir = "output/assets"
images_dir = "content/assets/images"
javascripts_dir = "content/assets/javascripts"
sass_dir = "content/assets/stylesheets"

# -----------------------------------------------
# Output
# -----------------------------------------------

output_style = :compressed
preferred_syntax = :scss
relative_assets = true

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

