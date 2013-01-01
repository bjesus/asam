# Shelves

Shelves is a Ruby on Rails application that stores files. It was designed to be used as an organization library and thus it's expertise is handling files as documents and images, but it can be used to archive any sort of files.

[![Build Status](https://travis-ci.org/bjesus/shelves.png?branch=master)](https://travis-ci.org/bjesus/shelves) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/bjesus/shelves)

## Features
* Search engine
* Advanced tagging system
* Comments
* Ratings
* Multiple files upload
* Simple configuration

## Installation
Setting up Shelves is quite straight forward and should be very simple to anyone experienced with RoR.

1. Edit `config/database.yml` to match your database settings.
2. Shelves has been tested with Ruby 1.8.7, and uses [Bundler](https://github.com/carlhuda/bundler) to set up it's dependencies.
    
        bundle install
    
3. Create your database

        rake db:create

4. Run Shelves

        rails s
        
## Contribution
Shelves needs help mostly (but not only) in these fields:
* Translations - currently only English and Hebrew are supported
* Coding style improvments - I'm not a Ruby expert and I'm sure things could have been written better
* New file types parsers & thumbnailers

## Troubleshooting
I try to [make sure the code runs](https://travis-ci.org/bjesus/shelves), but obviously things can go wrong sometimes.
Use [the project issue tracker](https://github.com/bjesus/shelves/issues) in case of need.

## Credit
This project wouldn't be possible without Rails, jQuery, Thinking Sphinx, Plupload, acts-as-taggable-on, acts_as_commentable, ajaxful_rating_jquery and a messed up biological clock.

## License
Shelves is released under the [GPL](http://opensource.org/licenses/GPL-3.0). If this is stopping you from using it, let me know.