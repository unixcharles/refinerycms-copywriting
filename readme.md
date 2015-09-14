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

__And if it's a model you need to scope against rather than a page?__

Include Refinery::Copywriting::Phraseable into the model:

```ruby
class Article < Refinery::Core::BaseModel
  include Refinery::Copywriting::Phraseable
end
```

Then you can use :target in the options hash:

```erb
<%= copywriting('read more', { :scope => 'footer', :target => @article }) do %>
  To find out more please email: theauthor@example.com
<% end %>
```

In order to see a copywriting tab for the model in the Refinery backend you'll
need to adjust the model's admin _form.html.erb partial.

Add a copywriting tab heading:

```erb
<ul id="page_parts">
  ... refinery tab headings ...
  <li class='ui-state-default' id="copywriting_tab">
    <%= link_to 'Copywriting', "#copywriting_tab_0" %>
  </li>
</ul>
```

And then the copywriting tab content:

```erb
<div id="page_part_editors">
  ... refinery tabs ...
  <div class='page_part' id='copywriting_tab_0'>
    <%= render '/refinery/pages/admin/tabs/copywriting', :f => f %>
  </div>
</div>
```

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
