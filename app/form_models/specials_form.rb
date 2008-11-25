class SpecialsForm < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :email, :string
  column :phone, :string
  column :special, :string
  column :comments, :string
  
  validates_presence_of :name, :email, :special
end