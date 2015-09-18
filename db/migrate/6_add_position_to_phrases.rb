class AddPositionToPhrases < ActiveRecord::Migration

  def self.up
    add_column Refinery::Copywriting::Phrase.table_name, :position, :integer
  end

  def self.down
    remove_column Refinery::Copywriting::Phrase.table_name, :position
  end

end
