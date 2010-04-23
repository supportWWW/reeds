class Accessory < ActiveRecord::Base
  
  money :price, :currency => false
  money :vat, :currency => false
  money :excl, :currency => false

  belongs_to :new_vehicle
end
