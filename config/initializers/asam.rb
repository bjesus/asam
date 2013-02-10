# coding: utf-8

require "ostruct"
     
App = OpenStruct.new({
  :title => "Asam",	                          # Title of your website
  :address => "asam.website.com",             # URL of your website
  :organization => OpenStruct.new({
	  :name => "My Organization",               # Your organization name
	  :url => "http://www.website.com"          # Your organization URL (not Asam's)
  }),
  :s3 => OpenStruct.new({                     # Amazon S3 settings
    :enabled => false,                        # false = locally, true = S3
    :bucket => "asam"                         # S3 bucket name
  }),
  :show_register_link => true,                # Direct people to registration page
  :use_phone_registration => false,           # Allow user to register only if phone is listed
  :force_introduction => true,                # Direct new users to see help page on first 3 visits
  :new_items => 20,                           # Amount of new items to list on the frontpage
  :hot_items => 7,                            # Amount of popular items to list on the frontpage
  :items_per_page => 10,                      # Amount of items per page on a tag listing
  :admin_email => "your@email.com",           # Admin's email
  :links => [
    OpenStruct.new({
      :name => "Search engines",
      :content => [
        OpenStruct.new({:title => "Google", :href => "http://www.google.com"}),
        OpenStruct.new({:title => "DuckDuckGo", :href => "http://www.duckduckgo.com"}),
      ]
    }),
    OpenStruct.new({
      :name => "News",
      :content => [
        OpenStruct.new({:title => "BBC", :href => "http://www.bbc.co.uk"}),
        OpenStruct.new({:title => "CNN", :href => "http://www.cnn.com"}),
      ]
    }),
    OpenStruct.new({
      :name => "Internal Systems",
      :content => [     
        OpenStruct.new({:title => "Address Book", :href => "http://addressbook.website.com"}),
        OpenStruct.new({:title => "E-Mail", :href => "http://mail.website.com"}),
      ]
    })
  ]
})
