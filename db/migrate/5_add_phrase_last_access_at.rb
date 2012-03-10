class AddPhraseLastAccessAt < ActiveRecord::Migration

  def self.up
    add_column Refinery::Copywriting::Phrase.table_name, :last_access_at, :date
  end

  def self.down
    remove_column Refinery::Copywriting::Phrase.table_name, :last_access_at
  end

end
