class Accessory < ActiveRecord::Base
  
  money :price
  belongs_to :new_vehicle
end
