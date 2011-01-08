module ApplicationHelper

  def how_many_texts
    Text.count
  end

  def how_many_authors
    Text.tag_counts_on(:author).length
  end

  def bookshelf_random
    return rand(1000)
  end

  def related_to(item)
    same_tags = Text.tagged_with(item.tags)
    if same_tags != {} 
      same_tags = same_tags - [item]
    end
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
    rm = Text.tagged_with tag
    rm.each do |text|
      text.images.each do |image|
        image.destroy()
      end
     text.destroy()
    end
  end

  def merge_tags(tags, new_tag)
    tags.each do |tag|
      Text.tagged_with(tag).each do |text|
        text.tag_list = text.tag_list.remove(tag) + [new_tag]
        text.save
      end
    end
  end

  def author_tags(tags, new_tag)
    tags.each do |tag|
      Text.tagged_with(tag).each do |text|
        text.author_list = text.author_list.remove(tag) + [new_tag]
        text.save
      end
    end
  end

  def hebrew_file_type(ext)
    file_type = case ext.downcase
      when "doc" then "מסמך וורד 2003"
      when "docx" then "מסמך וורד 2007"
      when "mp3" then "צליל"
      when "ppt" then "מצגת פאוור-פוינט 2003"
      when "pptx" then "מצגת פאוור-פוינט 2007"
      when "pdf" then "מסמך אקרובט"
      when "jpg" then "תמונה"
      else "קובץ לא מוכר"
    end
    return file_type
  end
end
