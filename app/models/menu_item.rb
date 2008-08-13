class MenuItem < ActiveRecord::Base
  
  validate :path_or_page
  validates_presence_of :title, :position
  
  belongs_to :page
  belongs_to :parent, :class_name => 'MenuItem'
  has_many :children, :class_name => 'MenuItem', :foreign_key => 'parent_id'
  
  before_save :set_depth
  
  def calculate_depth( current_value = 0 )
    if self.parent_id.nil? 
      current_value
    else
      current_value + parent.calculate_depth( current_value + 1 )
    end
  end  
  
  def title_with_depth
    "#{'-- ' * depth }#{title}"
  end
  
  protected
  
  def set_depth
    write_attribute_with_dirty(:depth, calculate_depth)
  end

  def path_or_page
    if !path.blank? && !page_id.blank?
      errors.add_to_base( 'You must select a page or define a path, you can not do both' )
    end
    
    if path.blank? && page_id.blank?
      errors.add_to_base( 'You must at least select a page or define a path' )
    end
    
  end
  
end
