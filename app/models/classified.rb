class Classified < ActiveRecord::Base
  
  validates_presence_of :year, :price_in_cents, :model_variant_id
  money :price
  
end
