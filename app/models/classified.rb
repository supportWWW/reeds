class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id
  money :price
  
  belongs_to :model_variant
  
  def humanize_model
    model = model_variant.model
    "#{model.make.name} #{model.name} #{model_variant.year}"
  end
end
