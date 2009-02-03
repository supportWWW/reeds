class SpecialsForm < ActiveRecord::BaseWithoutTable
  column :first, :string
  column :last, :string
  column :email, :string
  column :phone, :string
  column :special, :string
  column :comments, :string
  
  validates_presence_of :first, :last, :email, :special
end