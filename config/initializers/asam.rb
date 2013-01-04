# coding: utf-8

require "ostruct"
     
App = OpenStruct.new({
  :title => "מעין",	                          # Title of your website
  :organization => OpenStruct.new({
	  :name => "דרור ישראל",                    # Your organization name
	  :url => "http://www.drorisrael.org.il"    # Your organization URL (not Asam's URL)
  }),
  :show_register_link => false,               # Direct people to registration page
  :use_phone_registration => true,            # Allow user to register only if phone is listed
  :force_introduction => true,                # Direct new users to see help page on first 3 visits
  :new_items => 20,                           # Amount of new items to list on the frontpage
  :hot_items => 7,                            # Amount of popular items to list on the frontpage
  :items_per_page => 10,                      # Amount of items per page on a tag listing
  :admin_email => "bjesus@gmail.com",         # Admin's email
})