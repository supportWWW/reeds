class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id
  money :price
  
  has_permalink [:humanize, :id]

  belongs_to :model_variant
  
  belongs_to :model # denormalized for search
  belongs_to :make # denormalized for search
  
  before_save :set_make_and_model
  
  named_scope :available, :conditions => { :removed_at => nil }
  named_scope :cyberstock, :conditions => { :removed_at => nil, :cyberstock => true }
  
  def humanize
    model = model_variant.model
    "#{model.make.common_name} #{model.common_name}"
  end
  
  def removed?
    !removed_at.nil?
  end
  
  class << self
    
    def find_with_permalink( *args )
      if args.size == 1 and args.first.kind_of?( String )
        find_without_permalink :first, :conditions => { :permalink => args.first }
      else
        find_without_permalink( *args )
      end
    end
    
    alias_method_chain :find, :permalink
    
  end

private

  # denormalization for search
  def set_make_and_model
    variant = ModelVariant.find(self.model_variant_id)
    self.model = variant.model
    self.make = variant.model.make
  end

end
