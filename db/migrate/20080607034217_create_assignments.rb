class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :branch_id
      t.integer :salesperson_id
      t.boolean :enabled, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
