class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :name, :null => false
      t.integer :appId, :null => false
      t.string :author, :null => false
      t.text :description, :null => false
      t.string :category, :null => false
      t.date :birthday, :null => false
      t.string :platform, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
