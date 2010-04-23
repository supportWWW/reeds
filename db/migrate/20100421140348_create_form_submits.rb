class CreateFormSubmits < ActiveRecord::Migration
  def self.up
    create_table :form_submits do |t|
      t.column :form_name, :string, :limit => 32, :null => false
      t.column :product_id, :integer
      t.column :created_at, :timestamp
      t.timestamps
    end
  end

  def self.down
    drop_table :form_submits
  end
end
