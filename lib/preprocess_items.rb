def paginate_articles
  articles_to_paginate = articles

  article_groups = []
  until articles_to_paginate.empty?
    article_groups << articles_to_paginate.slice!(0..4)
  end

  article_groups.each_with_index do |subarticles, i|
    first = i * 5 + 1
    last  = (i + 1) * 5

    @items.create(
      "<%= render '/pagination_page.erb', :item_id => #{i} %>",
      { :title => "Archive (articles #{first} to #{last})" },
      "/blog/archive/#{i + 1}"
    )
  end
end
