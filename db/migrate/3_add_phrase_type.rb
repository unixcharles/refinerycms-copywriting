class AddPhraseType < ActiveRecord::Migration

  def self.up
    add_column :cw_phrases, :phrase_type, :string
  end

  def self.down
    remove_column :cw_phrases, :phrase_type
  end

end
