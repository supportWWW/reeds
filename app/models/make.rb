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
  
  def find_models_in_stock
    Model.find_by_sql(%$
                        SELECT DISTINCT m.* FROM models m
                        INNER JOIN classifieds c ON c.model_id = m.id
                        WHERE m.make_id = #{id}
                        AND c.removed_at IS NULL
                        ORDER BY m.name
                       $)
  end

  def find_model_ranges_in_stock
    ModelRange.find_by_sql(%$
                        SELECT DISTINCT m.* FROM model_ranges m
                        INNER JOIN new_vehicle_variants c ON c.model_range_id = m.id
                        INNER JOIN new_vehicles n ON n.id = c.new_vehicle_id
                        WHERE m.make_id = #{id}
                        AND n.enabled = 1
                        ORDER BY m.name
                       $)
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
                          INNER JOIN new_vehicles n ON n.id = v.new_vehicle_id
                          INNER JOIN makes m ON m.id = v.make_id
                          WHERE n.enabled = 1
                          ORDER BY m.name
                         #)
    end
    
    def for_select
      find( :all, :order => 'name' ).collect { |i| [ i.name, i.id ] }
    end
    
  end
  
end
