module Refinery
  module Copywriting
    class Phrase < ActiveRecord::Base

      belongs_to :page, :class_name => 'Refinery::Page'
      translates :value if self.respond_to?(:translates)
      validates :name, :presence => true

      attr_accessible :locale, :name, :default, :value, :scope, :page, :page_id, :phrase_type

      if self.respond_to?(:translation_class)
        self.translation_class.send :attr_accessible, :locale
      end

      class << self
        def for(name, options = {})
          options = {:phrase_type => 'text', :scope => 'default'}.merge(options)
          name = name.to_s
          page_id = (options[:page].try(:id) || options[:page_id] || nil)

          if (phrase = self.where(:name => name, :page_id => page_id).first).nil?
            phrase = self.create(:name => name,
                                 :scope => options[:scope],
                                 :value => options[:value],
                                 :default => options[:default],
                                 :page_id => page_id,
                                 :phrase_type => options[:phrase_type])
          end

          phrase.default_or_value
        end
      end

      def default_or_value
        value.present? ? value : default
      end

    end
  end
end