class AddSearchIndexes < ActiveRecord::Migration
  def change
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :target_type, :target_id], unique: true, name: 'by_scoped_target'
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :page_id], unique: true, name: 'by_scoped_page'
  end
end
