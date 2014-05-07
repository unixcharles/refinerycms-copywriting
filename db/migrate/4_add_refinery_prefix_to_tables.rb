class AddRefineryPrefixToTables < ActiveRecord::Migration

  def self.up
    rename_table :copywriting_phrases, :refinery_copywriting_phrases
    rename_table :copywriting_phrase_translations, :refinery_copywriting_phrase_translations
  end

  def self.down
    rename_table :refinery_copywriting_phrases, :copywriting_phrases
    rename_table :refinery_copywriting_phrase_translations, :copywriting_phrase_translations
  end

end
