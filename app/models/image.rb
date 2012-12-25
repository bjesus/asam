# encoding: utf-8

class Image < ActiveRecord::Base
  has_attached_file :photo,
                        :styles => { :thumb => { :geometry => "85x120>", :quality => 60, :format => 'JPG' } },
                        :whiny => false, 
                        :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
  belongs_to :user
  belongs_to :text

  named_scope :ordered, :order => "rating_average_quality DESC"

  ajaxful_rateable :stars => 5, :dimensions => [:quality], :allow_update => true, :cache_column => :rating_average


  before_save :extract_data


  def msword?
    photo_content_type =~ %r{^application/(?:ms-word|msword|wordprocessingml)$}
  end

  private

  # Retrieves metadata for Word files
  def extract_data
    return unless msword?
    path = photo.queued_for_write[:original].path
    require 'open3'
    data = ""
    Open3.popen3("antiword", path) { |i, o| data = o.read }
    self.description = data
  end

end
