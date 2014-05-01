class CreateCopywritings < ActiveRecord::Migration

  def self.up
    create_table :cw_phrases do |t|
      t.string :name
      t.text :default
      t.text :value
      t.string :scope
      t.integer :page_id

      t.timestamps
    end

    add_index :cw_phrases, [:name, :scope]
  end

  def self.down
    Refinery::UserPlugin.destroy_all({:name => "refinerycms_cw"})

    drop_table :cw_phrases
  end

end
