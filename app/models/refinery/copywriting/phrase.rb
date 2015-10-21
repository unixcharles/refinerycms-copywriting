module Refinery
  module Copywriting
    class Phrase < Refinery::Core::BaseModel

      belongs_to :page, :class_name => 'Refinery::Page'
      translates :value if self.respond_to?(:translates)
      validates :name, :presence => true

      default_scope { order([:scope, :name]) }

      def self.for(name, options = {})
        options = {:phrase_type => 'text', :scope => 'default'}.merge(options.reject {|k,v| v.blank? })
        options[:name] = name.to_s
        options[:page_id] ||= options[:page].try(:id)

        phrase = self.includes(:translations).find_by_name_and_scope_and_page_id(options[:name], options[:scope], options[:page_id]) || self.create(options)
        phrase.update_attributes(options.except(:value, :page, :page_id, :locale))
        phrase.last_access_at = Date.today
        phrase.save if phrase.changed?

        phrase.default_or_value
      end

      def default_or_value
        value.present? ? value : default
      end

    end
  end
end
