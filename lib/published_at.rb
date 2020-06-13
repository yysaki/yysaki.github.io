# frozen_string_literal: true

def published_at(post)
  yyyy, mm, dd = File.basename(post.identifier).split('-').map(&:to_i)
  Date.new(yyyy, mm, dd)
end
