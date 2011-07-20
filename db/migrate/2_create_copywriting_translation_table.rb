class CreateCopywritingTranslationTable < ActiveRecord::Migration

  def self.up
    ::CopywritingPhrase.create_translation_table!({
        :value => :text
      }, {
        :migrate_data => true
      })
  end

  def self.down
    ::CopywritingPhrase.drop_translation_table! :migrate_data => true
  end

end
