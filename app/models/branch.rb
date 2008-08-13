class Branch < ActiveRecord::Base
  has_many :assignments
  has_many :salespeople, :through => :assignments, :dependent => :destroy
  
  validates_presence_of :name
  
end
