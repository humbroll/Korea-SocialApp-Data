class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
      t.integer :rank, :null => false
      t.string :orderType, :null => false
      t.float :rating, :null => false
      t.integer :downloadCount, :null => false
      t.integer :app_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ranks
  end
end
