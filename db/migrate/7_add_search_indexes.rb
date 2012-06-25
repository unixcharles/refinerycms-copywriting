class AddSearchIndexes < ActiveRecord::Migration
  def change
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :target_type, :target_id], unique: true
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :page_id], unique: true
  end
end
