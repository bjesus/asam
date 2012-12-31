# Shelves
Shelves is a Ruby on Rails application that stores files. It was designed to be used as an organization library and thus it's expertise is handling files as documents and images, but it can be used to archive any sort of file.

Shelves features a search engine and an advanced tagging system that allows the user to find stuff she didn't know the library holds.

Shelves is closed for it's registered users, and these users can upload new content to it easily. The interface is currently Hebrew only, but that's the first TODO item.

# Installation
Setting up Shelves is quite straight forward and should be very simple to anyone experienced with RoR.
1. Edit `config/database.yml` to match your database settings.
2. Shelves has been tested with Ruby 1.8.7, and uses [Bundler](https://github.com/carlhuda/bundler) to set up it's dependencies.
        bundle install
        
3. Create your database
        rake db:create
        
4. Run Shelves
        rails s
        
# License
Shelves is released under the [GPL](http://opensource.org/licenses/GPL-3.0). If this is a problem for your project, tell me about it.

