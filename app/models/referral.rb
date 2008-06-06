class Referral < ActiveRecord::Base
  
  validates_presence_of :name, :redirect_to
  
  has_many :visits
  
end
