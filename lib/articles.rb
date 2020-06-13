# frozen_string_literal: true

def articles
  items
    .select { |i| i.identifier.to_s.match(/posts/) }
    .sort_by(&:identifier)
    .reverse
end
