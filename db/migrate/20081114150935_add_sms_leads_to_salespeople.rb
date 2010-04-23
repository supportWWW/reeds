class AddSmsLeadsToSalespeople < ActiveRecord::Migration
  def self.up
    add_column :salespeople, :sms_contact_me, :boolean
  end

  def self.down
  end
end
