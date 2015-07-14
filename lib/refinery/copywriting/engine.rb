module Refinery
  module Copywriting
    class Engine < Rails::Engine

      include Refinery::Engine

      isolate_namespace Refinery::Copywriting

      config.autoload_paths += %W( #{config.root}/lib )

      config.to_prepare do
        ::Refinery::Page.module_eval do
          has_many :copywriting_phrases, :dependent => :destroy, :class_name => 'Refinery::Copywriting::Phrase'
          accepts_nested_attributes_for :copywriting_phrases, :allow_destroy => false
        end
        Decorators.register! ::Refinery::Copywriting.root

        Rails.application.config.assets.precompile += %w(refinery/copywriting.css)
      end

      before_inclusion do
        ::ApplicationController.helper(CopywritingHelper)
      end

      initializer "register refinery_copywriting plugin", :after => :set_routes_reloader do |app|
        ::Refinery::Pages::Tab.register do |tab|
          tab.name = ::I18n.t(:'refinery.plugins.refinerycms_copywriting.title')
          tab.partial = '/refinery/pages/admin/tabs/copywriting'
        end

        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinerycms_copywriting'
          plugin.url = {:controller => '/refinery/copywriting/admin/phrases'}
          plugin.menu_match = /copywriting/
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Copywriting)
      end
    end
  end
end
