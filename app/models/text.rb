class Text < ActiveRecord::Base
  versioned
  belongs_to :user
  acts_as_commentable
  acts_as_taggable_on :year, :language, :author, :tags, :sources, :age, :kind, :maagal, :catalog, :sender, :customer
  has_many :images
  validates_presence_of :name, :user_id
  
  scope :recent, order("texts.created_at DESC")
  scope :with_files, lambda {
    joins("join images on images.text_id = texts.id").
    where("images.created_at IS NOT NULL AND images.created_at <= ?", Time.zone.now).
    group("texts.id")
  }

  define_index do
    # fields
    indexes name, :sortable => true
    indexes content
    #indexes user.name, :as => :user, :sortable => true
    
    # attributes
    #has user_id, created_at, updated_at
  end
  
  def number_of_images
    Image.count(:conditions => ['text_id = ?', id])
  end


end
