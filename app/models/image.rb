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

end
