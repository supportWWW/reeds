class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.string :parent_type
      t.integer :parent_id
      t.date :date
      t.string :referer
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
    add_index :stats, [:parent_type, :parent_id, :date]
  end

  def self.down
    drop_table :stats
  end
end
