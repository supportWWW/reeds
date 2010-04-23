class CreateModelVariants < ActiveRecord::Migration
  def self.up
    create_table :model_variants do |t|
      t.integer :model_id
      t.integer :year
      t.string :mead_mcgrouther_code
      t.timestamps
    end
    
    add_index :model_variants, :model_id
    add_index :model_variants, :year
    add_index :model_variants, :mead_mcgrouther_code
    
  end

  def self.down
    drop_table :model_variants
  end
end
