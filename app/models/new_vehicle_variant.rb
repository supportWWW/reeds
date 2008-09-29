class NewVehicleVariant < ActiveRecord::Base
  
  money :price, :currency => false
  money :vat, :currency => false
  money :excl, :currency => false
  
  belongs_to :new_vehicle
  
  belongs_to :model_range # denormalized for search
  belongs_to :make # denormalized for search
  
  validates_presence_of :name, :price
  
  
  before_validation :set_make_and_model_range
  has_permalink :humanize # needs to be after before_validation :set_make_and_model_range
  
  
  def humanize
    "#{model_range.humanize} #{name}"
  end

private

  # denormalization for search
  def set_make_and_model_range
    if new_vehicle_id
      mr = new_vehicle.model_range
      self.model_range = mr
      self.make = mr.make
    end
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
end
