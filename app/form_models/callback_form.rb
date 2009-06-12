class CallbackForm < ActiveRecord::BaseWithoutTable
  column :first, :string
  column :last, :string
  column :phone, :string
  column :vehicle, :string
  column :branch_id, :integer
  
  validates_presence_of :first, :last, :phone, :vehicle, :branch_id
end