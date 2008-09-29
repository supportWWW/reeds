class Make < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :models, :dependent => :destroy
  has_many :model_ranges, :dependent => :destroy
  
  before_save :set_common_name
  
  def set_common_name
    if common_name.blank?
      write_attribute_with_dirty :common_name, name.downcase.titleize
    end
  end
  
  class << self 
  
    def find_in_stock
      Make.find_by_sql(%#
                          SELECT DISTINCT m.* FROM classifieds c
                          INNER JOIN makes m ON m.id = c.make_id
                          WHERE c.removed_at IS NULL
                          ORDER BY m.name
                         #)
    end

    def new_vehicles
      Make.find_by_sql(%#
                          SELECT DISTINCT m.* FROM new_vehicle_variants v
                          INNER JOIN makes m ON m.id = v.make_id
                          ORDER BY m.name
                         #)
    end
    
    def for_select
      find( :all, :order => 'name' ).collect { |i| [ i.name, i.id ] }
    end
    
  end
  
end
