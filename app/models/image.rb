# encoding: utf-8

class Image < ActiveRecord::Base
  has_attached_file :photo
  belongs_to :user
  belongs_to :text
end
