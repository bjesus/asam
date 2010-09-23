class Text < ActiveRecord::Base
  versioned
  acts_as_commentable
  acts_as_taggable_on :year, :language, :author, :tags, :sources
end
