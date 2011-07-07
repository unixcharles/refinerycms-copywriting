# Copywriting engine for Refinery CMS

__How do you manage your string in RefineryCMS?__

Extended copywriting management: extract all your strings and leave no
human word behind + i18n.

Do like this

    <%= copywriting('phone number', { :scope => 'header', :default => '1-800-888-5555' }) %>

Or like that

    <%= copywriting('slogan', { :scope => 'header'}) do %>
      Insert a slogan here
    <% end %>

Just give it a name anyway

    <%= copywriting('note1') %>

Then edit the copywriting from the backend:

![screenshot](http://s3.amazonaws.com:80/unixcharles.baconfile.com/screenshot1.png)

__Okay, but now, what if you want to have a string that change on every page, like a slogan?__

Pass the `@page` object in the options hash:

    <%= copywriting('slogan', { :scope => 'header', :page => @page }) do %>
      Insert a slogan here
    <% end %>

![screenshot](http://s3.amazonaws.com:80/unixcharles.baconfile.com/screenshot2.png)

## Install

    # Gemfile
    gem 'refinerycms-copywriting'

    bundle
    rails generate refinerycms_copywriting
    rake db:migrate

## Pull request?

Yes.

## Helper method

    copywriting('name', options) { ... optional block ... }

    {
      :default => 'string...',        # if no block is given
      :html_safe => true,             # it escape html by default
      :page => @page,                 # the string will be scoped to the page, if no page_id option is provided
      :page_id => 1                   # using integer instead of page object
      :phrase_type => "wysiwyg"       # default is "text". Sets the type of field this is when editing. "string" gives you a single line text field. "text" gives you a multiline textarea. "wysiwyg" gives you the default Refinery visual editor. Remember to set :html_safe => true when using this option.
    }
