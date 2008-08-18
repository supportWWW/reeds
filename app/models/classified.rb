class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id
  money :price
  
  belongs_to :model_variant
  
  belongs_to :model # denormalized for search
  belongs_to :make # denormalized for search
  
  before_save :set_make_and_model
  
  def humanize_model
    model = model_variant.model
    "#{model.make.name} #{model.name} #{model_variant.year}"
  end
  
private

  # denormalization for search
  def set_make_and_model
    variant = ModelVariant.find(self.model_variant_id)
    self.model = variant.model
    self.make = variant.model.make
  end
end
