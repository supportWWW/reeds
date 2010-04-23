class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :referral_id
      t.string :referer
      t.string :remote_ip
      t.string :user_agent
      
      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
