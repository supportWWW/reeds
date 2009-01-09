class UsedVehicleEnquiryForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :phone, :string
  column :comments, :string
  column :insurance, :string
  column :vehicle, :string
  column :branch_id, :integer
  
  validates_presence_of :name, :vehicle, :phone
end