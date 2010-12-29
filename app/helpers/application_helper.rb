module ApplicationHelper

  def how_many_texts
    Text.count
  end

  def how_many_authors
    Text.tag_counts_on(:author).length
  end

  def related_to(item)
    same_tags = Text.tagged_with(item.tags)
    same_tags = same_tags - [item]
    return same_tags
  end

  def to_author(tag)
    Text.tagged_with(tag, :on => :tags).each do |text|
      text.tag_list = text.tag_list.remove(tag)
      text.author_list = text.author_list.add(tag)
      text.save()
    end
  end

  def clear_tag(tag)
    rm = Text.tagged_with
    rm.each do |text|
      text.images.each do |image|
        image.destroy()
      end
     text.destroy()
    end
  end

end
