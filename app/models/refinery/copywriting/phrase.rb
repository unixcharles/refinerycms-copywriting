module Refinery
  module Copywriting
    class Phrase < Refinery::Core::BaseModel

      belongs_to :page, :class_name => 'Refinery::Page'
      belongs_to :target, :polymorphic => true
      translates :value if self.respond_to?(:translates)
      validates :name, :presence => true

      attr_accessible :locale, :name, :default, :value, :scope, :page, :page_id, :target, :target_id, :target_type, :phrase_type

      if self.respond_to?(:translation_class)
        self.translation_class.send :attr_accessible, :locale
      end

      default_scope order([:scope, :name])

      scope :untargeted, where(:page_id => nil, :target_id => nil)
      scope :for_scope, lambda { |scope_name| where(:scope => scope_name) }

      def self.for(name, options = {})
        options = {:phrase_type => 'text', :scope => 'default'}.merge(options.reject {|k,v| v.blank? })
        options[:name] = name.to_s
        options[:page_id] ||= options[:page].try(:id)
        if target = options.delete(:target)
          options[:target_type] = target.class.to_s
          options[:target_id] = target.id
        end

        phrase = if options[:target_type] and options[:target_id]
          where(options.slice(:name, :scope, :target_type, :target_id)).first
        else
          where(options.slice(:name, :scope, :page_id)).first
        end
        phrase ||= create(options)

        phrase.update_attributes(options.except(:value, :page, :page_id, :target, :target_type, :target_id, :locale))
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
