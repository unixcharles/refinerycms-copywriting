class AddSearchIndexes < ActiveRecord::Migration
  def change
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :page_id, :target_type, :target_id], unique: true, name: 'by_scoped_page_or_target'
  end
end
