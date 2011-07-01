class CopywritingPhrase < ActiveRecord::Base
  belongs_to :page

  translates :value if self.respond_to?(:translates)

  validates :name, :presence => true
  

  attr_accessible :locale, :name, :default, :value, :scope, :page_id

  def self.for(name, scope, default, page_id)
    name = name.to_s.downcase
    scope = scope.to_s.downcase

    if phrase = self.where(:name => name).first
      phrase.default_or_value
    else
      if phrase = self.create(:name => name, :scope => scope, :default => default, :page_id => page_id)
        phrase.default
      else
        "<span>Copywriting error: #{phrase.to_a.join(', ')}<span>"
      end
    end
  end

  def default_or_value
    value.blank? ? default : value 
  end
end
