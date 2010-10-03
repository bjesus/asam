module ApplicationHelper

  def how_many_texts
    Text.count
  end

  def how_many_authors
    Text.tag_counts_on(:author).length
  end

end
