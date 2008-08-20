class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id, :stock_code
  money :price
  
  has_permalink [:humanize, :stock_code]

  belongs_to :model_variant
  
  belongs_to :model # denormalized for search
  belongs_to :make # denormalized for search

  belongs_to :physical, :class_name => 'Classified', :foreign_key => 'physical_id'
  
  before_save :set_make_and_model
  
  named_scope :available, :conditions => { :removed_at => nil }
  named_scope :live_cyberstock, :conditions => ["removed_at is NULL AND cyberstock = 1 AND expires_on > ?", Date.today]
  named_scope :expired_cyberstock, :conditions => ["removed_at is NULL AND cyberstock = 1 AND expires_on <= ?", Date.today]
  named_scope :physical, :conditions => { :removed_at => nil, :cyberstock => false }, :order => "stock_code"
  
  def humanize
    if model_variant
      model = model_variant.model
      "#{model.make.common_name} #{model.common_name}"
    else
      ""
    end
  end
  
  def removed?
    !removed_at.nil?
  end
  
  class << self
    
    def find_with_permalink( *args )
      if args.size == 1 and !args.first.kind_of?(Symbol) and args.first.to_i.to_s != args.first.to_s
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
    if model_variant_id
      variant = ModelVariant.find(self.model_variant_id)
      self.model = variant.model
      self.make = variant.model.make
    end
  end

end
