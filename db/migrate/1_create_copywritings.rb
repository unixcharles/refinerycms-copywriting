class CreateCopywritings < ActiveRecord::Migration

  def self.up
    create_table :copywriting_phrases do |t|
      t.string :name
      t.text :default
      t.text :value
      t.string :scope
      t.integer :page_id

      t.timestamps
    end

    add_index :copywriting_phrases, [:name, :scope]

    load(Rails.root.join('db', 'seeds', 'copywritings.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "refinerycms_copywriting"})

    drop_table :copywriting_phrases
  end

end
