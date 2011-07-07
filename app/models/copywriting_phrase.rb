class CopywritingPhrase < ActiveRecord::Base

  belongs_to :page
  translates :value if self.respond_to?(:translates)
  validates :name, :presence => true

  attr_accessible :locale, :name, :default, :value, :scope, :page_id, :phrase_type

  def self.for(name, options = {})
    options = {:phrase_type => 'text', :scope => 'default'}.merge(options)
    name = name.to_s

    if (phrase = self.where(:name => name).first).nil?
      phrase = self.create(:name => name,
                           :scope => options[:scope],
                           :default => options[:default],
                           :value => nil,
                           :page_id => (options[:page].try(:id) || options[:page_id] || nil),
                           :phrase_type => options[:phrase_type])
    end
    
    phrase.default_or_value
  end

  def default_or_value
    value.blank? ? default : value 
  end

end