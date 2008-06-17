class CreateModels < ActiveRecord::Migration
  def self.up
    create_table :models do |t|
      t.string :name
      t.string :common_name
      t.integer :make_id

      t.timestamps
    end
    
    add_index :models, :make_id
    add_index :models, :name
    
  end

  def self.down
    drop_table :models
  end
end
