# encoding: utf-8

class Image < ActiveRecord::Base
  if App.s3.enabled
    has_attached_file :photo,
                          :styles => { :thumb => { :geometry => "85x120>", :quality => 60, :format => 'JPG' } },
                          :whiny => false, 
                          :path => ":attachment/:id/:style/:filename",
                          :storage => :s3,
                          :s3_credentials => "#{Rails.root}/config/s3.yml",
                          :bucket => App.s3.bucket,
                          :url => ':s3_domain_url'
  else
    has_attached_file :photo,
                          :styles => { :thumb => { :geometry => "85x120>", :quality => 60, :format => 'JPG' } },
                          :whiny => false, 
                          :path => ":attachment/:id/:style/:filename",
                          :storage => :filesystem
  end
  belongs_to :user
  belongs_to :text

  scope :ordered, :order => "rating_average_quality DESC"

  ajaxful_rateable :stars => 5, :dimensions => [:quality], :allow_update => true, :cache_column => :rating_average

  after_post_process :extract_data

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
