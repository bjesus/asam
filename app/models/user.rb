# coding: utf-8

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "לא רשום במערכת!" unless open(Rails.root.join('phones.list')).grep(/#{value}/n) != []
  end
end

class User < ActiveRecord::Base
  has_many :texts
  validates_presence_of :firstname, :lastname
  validates_uniqueness_of :phone, :email
  has_friendly_id :urlname, :use_slug => true
  if App.use_phone_registration
    validates :phone, :presence => true, :phone => true, :length => { :within => 7..7 }
  end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :phone, :phoneext, :email, :password, :password_confirmation, :remember_me

  ajaxful_rater

  def display_name
    ' / <a href="/users/'+ urlname + '">' + fullname + '</a>'
  end

  def urlname
    firstname+lastname
  end

  def english
    (firstname+" "+lastname).to_url
  end

  def fullname
    firstname + " " + lastname
  end
end
