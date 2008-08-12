class Make < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :models, :dependent => :destroy
  
  before_save :set_common_name
  
  def set_common_name
    if common_name.blank?
      write_attribute_with_dirty :common_name, name.downcase.titleize
    end
  end
  
  class << self 
    
    def for_select
      find( :all, :order => 'name' ).collect { |i| [ i.name, i.id ] }
    end
    
  end
  
end
