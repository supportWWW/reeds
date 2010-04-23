class UsedVehicleEnquiryForm < ActiveRecord::BaseWithoutTable
  column :first, :string
  column :last, :string
  column :email, :string
  column :phone, :string
  column :comments, :string
  column :insurance, :string
  column :vehicle, :string
  column :branch_id, :integer
  column :classified_id, :integer
  
  validates_presence_of :first, :last, :vehicle, :phone
end