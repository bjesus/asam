class Text < ActiveRecord::Base
  versioned
  belongs_to :user
  acts_as_commentable
  acts_as_taggable_on :year, :language, :author, :tags, :sources, :age, :kind, :maagal
  has_many :images
  validates_presence_of :name, :user_id

  define_index do
    # fields
    indexes name, :sortable => true
    indexes content
    #indexes user.name, :as => :user, :sortable => true
    
    # attributes
    #has user_id, created_at, updated_at
  end

end
