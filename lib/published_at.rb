def published_at(post)
  yyyy, mm, dd = File.basename(post.identifier).split('-').map{|s| s.to_i}
  Date.new(yyyy, mm, dd)
end

