class NewVehicleEnquiryForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :phone, :string
  column :comments, :string
  column :insurance, :string
  column :vehicle, :string
  column :branch_id, :integer
  column :accessories, :string
  
  validates_presence_of :name, :phone, :vehicle
end