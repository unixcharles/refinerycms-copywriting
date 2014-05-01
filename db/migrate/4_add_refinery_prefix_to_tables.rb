class AddRefineryPrefixToTables < ActiveRecord::Migration

  def self.up
    rename_table :cw_phrases, :refinery_cw_phrases
    rename_table :cw_phrase_translations, :refinery_cw_phrase_translations
  end

  def self.down
    rename_table :refinery_cw_phrases, :cw_phrases
    rename_table :refinery_cw_phrase_translations, :cw_phrase_translations
  end

end
