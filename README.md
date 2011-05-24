# Adminv - adminstrative layouts made easy

Adminv is an administrative layout for Rails, which includes view helpers to make creating usable and pretty administrative console views a snap.

Really we just designed this for [our own
projects](http://www.involved.com.au) but figured others may benefit
from the fruits of our labour.


# Getting started

Start by adding the gem to your `gemfile`:

    gem 'adminv'
		
		_Manual Dependency (Until gem is fixed)_
		gem 'css3buttons', '0.9.4'

Then you can run the generators to create the public assets:

    $ rails g adminv:install
    $ rails g css3buttons

This will add some images, stylesheets and javascripts to your `/public`
directory. In addition, some view partials will be created under
`app/views/adminv` which you can use to access the different sections
of the layout.

__Please note__ if you would like to update, or make changes to the CSS,
we suggest you use the supplied `overrides.css` file. This way, any
future updates we make, won't disturb your stuff (unless you want it to).


# Why is there no layout?

The idea with adminv was to remove as much of the work as possible from
creating an adminstrative console. As such, all the core structure for
the layout is actually kept inside the gem, and the partials in
`app/views/adminv` are how you can manage the content in each of the key
spaces.

Also, it means that if we make any fundamental changes to the main
layout - you can safely update without breaking your work


# TODO: But I want to edit it! (Not yet Implemeted)

Understood! Generate away:

    $ rails g adminv:layout

Which will copy the template into you your `app/views/layouts`
directory.
