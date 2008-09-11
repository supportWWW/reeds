class NewVehicleVariant < ActiveRecord::Base
  
  money :price, :currency => false
  money :vat, :currency => false
  money :excl, :currency => false
  
  belongs_to :vehicle
  validates_presence_of :name, :price
end
