class FindCarForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :phone, :string
  column :criteria, :string
  
  validates_presence_of :name, :email, :criteria
end