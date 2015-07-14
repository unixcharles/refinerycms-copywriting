module Refinery
  module Copywriting
    module Phraseable
      extend ActiveSupport::Concern

      included do
        has_many :copywriting_phrases, :as => :target, :dependent => :destroy, :class_name => 'Refinery::Copywriting::Phrase'
        accepts_nested_attributes_for :copywriting_phrases, :allow_destroy => false
      end
    end
  end
end
