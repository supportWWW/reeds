class MenuItem < ActiveRecord::Base
  
  validate :path_or_page
  
  validates_presence_of :title, :position
  
  belongs_to :page
  belongs_to :parent, :class_name => 'MenuItem'
  
  validates_uniqueness_of :position, :scope => :parent_id
  
  has_many :children, :class_name => 'MenuItem', :foreign_key => 'parent_id'
  
  protected
  
  def path_or_page
    if !path.blank? && !page_id.blank?
      errors.add_to_base( 'You must select a page or define a path, you can not do both' )
    end
    
    if path.blank? && page_id.blank?
      errors.add_to_base( 'You must at least select a page or define a path' )
    end
    
  end
  
end
