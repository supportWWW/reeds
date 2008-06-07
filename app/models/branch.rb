class Branch < ActiveRecord::Base
  has_many :assignments
  has_many :salespeople, :through => :assignments
  
  validates_presence_of :name
  
end
