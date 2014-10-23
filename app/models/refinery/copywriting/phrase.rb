module Refinery
  module Copywriting
    class Phrase < Refinery::Core::BaseModel

      belongs_to :page, :class_name => 'Refinery::Page'
      belongs_to :targetable, :polymorphic => true
      translates :value if self.respond_to?(:translates)
      validates :name, :presence => true

      default_scope { order([:scope, :name]) }

      def self.untargeted
        where(:page_id => nil, :targetable_id => nil)
      end

      def self.for_scope(name)
        where(:scope => scope_name)
      end

      def self.for(name, options = {})
        options = {:phrase_type => 'text', :scope => 'default'}.merge(options.reject {|k,v| v.blank? })
        options[:name] = name.to_s
        options[:page_id] ||= options[:page].try(:id)
        if target = options.delete(:target)
          options[:targetable_type] = target.class.to_s
          options[:targetable_id] = target.id
        end

        phrase = transaction do
          where(options.slice(:name, :scope, :page_id, :targetable_type, :targetable_id)).first || create(options)
        end

        phrase.update_attributes(options.except(:value, :page, :page_id, :target, :targetable_type, :targetable_id, :locale))
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
