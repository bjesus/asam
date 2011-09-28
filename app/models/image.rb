# encoding: utf-8

class Image < ActiveRecord::Base
  has_attached_file :photo,
                        :styles => { :thumb => { :geometry => "85x120>", :quality => 60, :format => 'JPG' } },
                        :whiny => false, 
                        :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
  belongs_to :user
  belongs_to :text
end
