class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :name
      t.integer :appId
      t.string :author
      t.text :description
      t.string :category
      t.date :birthday
      t.string :platform

      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
