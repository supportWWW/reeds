class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|
      t.string :name
      t.string :source
      t.text :description
      t.integer :visits_count, :default => 0
      t.string :redirect_to, :default => '/'

      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
