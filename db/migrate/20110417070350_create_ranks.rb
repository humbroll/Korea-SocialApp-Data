class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
      t.integer :rank
      t.string :orderType
      t.float :rating
      t.integer :downloadCount
      t.references :app_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ranks
  end
end
