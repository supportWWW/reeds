class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id, :stock_code
  money :price
  

  belongs_to :model_variant
  
  belongs_to :model # denormalized for search
  belongs_to :make # denormalized for search

  before_validation :set_make_and_model
  has_permalink [:humanize, :stock_code] # needs to be after before_validation :set_make_and_model
  
  named_scope :available, lambda { { :conditions => ["removed_at is NULL AND (expires_on IS NULL OR expires_on > ?)", Date.today], :include => [:make, :model] } }
  named_scope :with_photos, lambda { { :conditions => ["removed_at is NULL AND img_url IS NOT NULL AND (expires_on IS NULL OR expires_on > ?)", Date.today], :include => [:make, :model] } }
  named_scope :no_photos, lambda { { :conditions => ["removed_at is NULL AND img_url IS NULL AND (expires_on IS NULL OR expires_on > ?)", Date.today], :include => [:make, :model] } }

  def cyberstock?
    kind_of?(Cyberstock)
  end

  def used_vehicle?
    kind_of?(UsedVehicle)
  end
  
  def humanize
    if make && model
      "#{make.common_name} #{model.common_name}"
    else
      ""
    end
  end
  
  def removed?
    !removed_at.nil?
  end
  
private

  # denormalization for search
  def set_make_and_model
    if model_variant_id
      variant = ModelVariant.find(self.model_variant_id)
      self.model = variant.model
      self.make = variant.model.make
    end
  end

end
