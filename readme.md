# Copywriting engine for Refinery CMS

[![Build Status](https://secure.travis-ci.org/unixcharles/refinerycms-copywriting.png)](http://travis-ci.org/unixcharles/refinerycms-copywriting)

__How do you manage your string in RefineryCMS?__

Extended copywriting management: extract all your strings and leave no
human word behind + i18n.

Do like this

```erb
<%= copywriting('phone number', { :scope => 'header', :default => '1-800-888-5555' }) %>
```

Or using block

```erb
<%= copywriting('slogan', { :scope => 'header' }) do %>
  Insert a slogan here
<% end %>
```

Just give it a name anyway

```erb
<%= copywriting('note1') %>
```

When it get more complex, avoid redundant options hash with options block

```erb
<% copywriting_options({ :scope => 'header', :phrase_type => 'wysiwyg' }) do %>
  ...
  <%= copywriting('contact information').html_safe do %>
    ...
  <% end %>
  ...
  <%= copywriting('phone number', { :phrase_type => 'string', :default => '1-800-888-5555' }) %>
  ...
<% end %>
```

Then edit the copywriting from the backend:

![screenshot](http://s3.amazonaws.com:80/unixcharles.baconfile.com/screenshot1.png)

__Okay, but now, what if you want to have a string that change on every page, like a slogan?__

Pass the `@page` object in the options hash:

```erb
<%= copywriting('slogan', { :scope => 'header', :page => @page }) do %>
  Insert a slogan here
<% end %>
```

![screenshot](http://s3.amazonaws.com:80/unixcharles.baconfile.com/screenshot2.png)

## Install

```ruby
# Gemfile
gem 'refinerycms-copywriting'
```

```bash
bundle
rails generate refinery:copywriting
rake db:migrate
```

## Pull request?

Yes.

## Helper method

```ruby
copywriting('name', options) { ... optional block ... }

{
  :default => 'string...',        # if no block is given
  :page => @page,                 # the string will be scoped to the page, if no page_id option is provided
  :page_id => 1                   # using integer instead of page object
  :phrase_type => "wysiwyg"       # default is "text". Sets the type of field this is when editing. "string" gives you a single line text field. "text" gives you a multiline textarea. "wysiwyg" gives you the default Refinery visual editor.
}

copywriting_options(options) { ... use copywriting helper with default options hash ... }
```
