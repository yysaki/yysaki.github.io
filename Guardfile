# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'nanoc' do
  watch('nanoc.yaml') # Change this to config.yaml if you use the old config file name
  watch('Rules')
  watch(%r{^(content|layouts|lib)/.*$})
end

guard 'livereload', :port => '35729' do
  watch(%r{^output/.*$})
end
