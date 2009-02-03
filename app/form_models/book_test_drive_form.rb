class BookTestDriveForm < ActiveRecord::BaseWithoutTable
  column :first, :string
  column :last, :string
  column :email, :string
  column :phone, :string
  column :comments, :string
  column :vehicle, :string
  column :branch, :string
  
  validates_presence_of :first, :last, :email, :vehicle, :branch
end