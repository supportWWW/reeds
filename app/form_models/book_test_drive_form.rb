class BookTestDriveForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :phone, :string
  column :comments, :string
  column :vehicle, :string
  column :branch, :string
  
  validates_presence_of :name, :email, :vehicle, :branch
end