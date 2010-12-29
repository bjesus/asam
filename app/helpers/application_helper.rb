module ApplicationHelper

  def how_many_texts
    Text.count
  end

  def how_many_authors
    Text.tag_counts_on(:author).length
  end

  def to_author(tag)
    Text.tagged_with(tag, :on => :tags).each do |text|
      text.tag_list = text.tag_list.remove(tag)
      text.author_list = text.author_list.add(tag)
      text.save()
    end
  end

end
