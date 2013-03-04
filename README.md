# Asam

Asam is a Ruby on Rails application that stores files. It was designed to be used as an organization library and thus it's expertise is handling files as documents and images, but it can be used to archive any sort of files.

[![Build Status](https://travis-ci.org/bjesus/asam.png?branch=master)](https://travis-ci.org/bjesus/asam) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/bjesus/asam)

## Features
* Search engine
* Advanced tagging system
* Multilingual
* Comments
* Ratings
* Multiple files upload
* Simple configuration

See screenshots at the end of this page.

## Installation
Setting up Asam is quite straight forward and should be very simple to anyone experienced with RoR.

1. Edit `config/database.yml` to match your database settings.
2. Asam has been tested with Ruby 1.8.7, and uses [Bundler](https://github.com/carlhuda/bundler) to set up it's dependencies.
    
        bundle install
    
3. Create your database

        rake db:migrate

3. Edit `config/initializers/asam.rb` according to your will

4. Run Asam

        rails s
        
## Contribution
Asam needs help mostly (but not only) in these fields:
* Translations - currently only English and Hebrew are supported
* Coding style improvments - I'm not a Ruby expert and I'm sure things could have been written better
* New file types parsers & thumbnailers

## What's with the name?
Asam (אסם) means barn or storehouse in Hebrew. We figured it's good name for a system that holds all our knowledge base.

## Troubleshooting
I try to [make sure the code runs](https://travis-ci.org/bjesus/asam), but obviously things can go wrong sometimes.
Use [the project issue tracker](https://github.com/bjesus/asam/issues) in case of need.

## Credit
This project wouldn't be possible without Rails, jQuery, Thinking Sphinx, Plupload, acts-as-taggable-on, acts_as_commentable, ajaxful_rating_jquery and a messed up biological clock.

The beautiful design was created by [@leshido](https://github.com/leshido/).

## License
Asam is released under the [GPL](http://opensource.org/licenses/GPL-3.0). If this is stopping you from using it, let me know.

## Screenshots
#### Index page, English
[![Index page](http://i.imgur.com/pVWM5KOl.png)](http://i.imgur.com/pVWM5KO.png)
#### Item page, Hebrew
[![Item page](http://i.imgur.com/sxZ8uc5l.png)](http://i.imgur.com/sxZ8uc5.png)
