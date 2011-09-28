# encoding: utf-8

class Image < ActiveRecord::Base
  has_attached_file :photo, :styles => { :thumb => { :geometry => "85x120>",
                        :quality => 40,
                        :format => 'JPG' }}
                    #:processors => [:thumbnail, :unoconv]
  belongs_to :user
  belongs_to :text
end
