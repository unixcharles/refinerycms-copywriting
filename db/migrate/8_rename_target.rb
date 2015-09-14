class RenameTarget < ActiveRecord::Migration
  def change
    rename_column Refinery::Copywriting::Phrase.table_name, :target_type, :targetable_type
    rename_column Refinery::Copywriting::Phrase.table_name, :target_id, :targetable_id
    remove_index Refinery::Copywriting::Phrase.table_name, name: 'by_scoped_page_or_target'
    add_index Refinery::Copywriting::Phrase.table_name, [:name, :scope, :page_id, :targetable_type, :targetable_id], unique: true, name: 'by_scoped_page_or_targetable'
  end
end

