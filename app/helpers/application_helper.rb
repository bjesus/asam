module ApplicationHelper

  def how_many_texts
    Text.count
  end

  def how_many_authors
    Text.tag_counts_on(:author).length
  end

  def bookshelf_random
    return rand(10000)
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

  def merge_authors(tags, new_tag)
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
  
  def find_dups(text)
    all = Text.find(:all, :conditions => ["name = ? AND content = ? AND description = ?", text.name, text.content, text.description])
    if all.count > 1
      return all
    else
      return false
    end
  end
  
  def merge_texts(texts)
    t = texts[0]
    texts.delete(t)
    text.each do |text|
      t.content = t.content.to_s + text.content.to_s
      t.description = t.description.to_s + text.description.to_s
      t.tags = t.tags + text.tags
      t.author = t.author + text.author
      t.images = t.images + text.images
      t.save
      text.destory
    end
  end
end
