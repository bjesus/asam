class Text < ActiveRecord::Base
  versioned
  acts_as_commentable
end
