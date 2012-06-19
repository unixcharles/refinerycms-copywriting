class AddTarget < ActiveRecord::Migration
  def change
    add_column Refinery::Copywriting::Phrase.table_name, :target_type, :string
    add_column Refinery::Copywriting::Phrase.table_name, :target_id, :integer
  end
end
