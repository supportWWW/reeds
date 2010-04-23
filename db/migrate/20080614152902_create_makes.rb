class CreateMakes < ActiveRecord::Migration
  def self.up
    create_table :makes do |t|
      t.string :name
      t.string :common_name
      t.string :website

      t.timestamps
    end
    
    add_index :makes, :name, :unique
    
    
  end

  def self.down
    drop_table :makes
  end
end
