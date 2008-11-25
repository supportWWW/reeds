class CallbackForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :phone, :string
  column :vehicle, :string
  column :branch_id, :integer
  
  validates_presence_of :name, :phone, :vehicle
end