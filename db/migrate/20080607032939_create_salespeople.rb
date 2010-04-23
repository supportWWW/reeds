class CreateSalespeople < ActiveRecord::Migration
  def self.up
    create_table :salespeople do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :salespeople
  end
end
