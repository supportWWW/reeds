class CreateClassifieds < ActiveRecord::Migration
  def self.up
    create_table :classifieds do |t|
      t.string :stock_code
      t.integer :stock_type
      t.integer :model_variant_id
      t.integer :year
      t.integer :price_in_cents
      t.string :colour
      t.string :reg_num
      t.integer :mileage
      t.text :features
      t.string :img_url
      t.boolean :best_buy
      t.integer :days_in_stock
      t.datetime :removed_at
      t.boolean :has_service_history
      t.boolean :cyberstock
      t.datetime :expires_at

      t.timestamps
    end
    
    add_index :classifieds, :stock_code, :unique => true
    add_index :classifieds, :model_variant_id
    add_index :classifieds, :price_in_cents
    
  end

  def self.down
    drop_table :classifieds
  end
end
