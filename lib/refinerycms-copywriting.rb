require 'refinerycms-base'

module Refinery
  module Copywriting
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        Page.module_eval do
          has_many :copywriting_phrases, :dependent => :destroy
          accepts_nested_attributes_for :copywriting_phrases, :allow_destroy => false
          attr_accessible :copywriting_phrases_attributes
        end
      end

      config.to_prepare do
        ::ApplicationController.helper(CopywritingHelper)
      end

      config.after_initialize do
        ::Refinery::Pages::Tab.register do |tab|
          tab.name = 'copywriting'
          tab.partial = '/admin/pages/tabs/copywriting'
        end
        Refinery::Plugin.register do |plugin|
          plugin.name = 'refinerycms_copywriting'
          plugin.url = {:controller => '/admin/copywriting_phrases', :action => 'index'}
          plugin.menu_match = /copywriting/
          plugin.activity = {
            :class => CopywritingPhrase,
            :title => 'Key'
          }
        end
      end
    end
  end
end
