class FindCarForm < ActiveRecord::BaseWithoutTable
  column :first, :string
  column :last, :string
  column :email, :string
  column :phone, :string
  column :criteria, :string
  
  validates_presence_of :first, :last, :email, :criteria
end