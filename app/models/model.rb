class Model < ActiveRecord::Base
  
  #validations
  validates_presence_of :name, :make_id
  validates_uniqueness_of :name, :scope => :make_id
  
  #associations
  belongs_to :make
  has_many :model_variants, :dependent => :destroy
  
  before_save :set_common_name
  
  def set_common_name
    if common_name.blank?
      write_attribute_with_dirty :common_name, name.downcase.titleize
    end
  end  
  
  def validate_model_name
    if Model.find( :first, :conditions => [ 'name like binary ? and make_id = ?', name, make_id ] )
      errors.add :name, 'has already been taken'
    end
  end
  
  class << self
    
    def models_for_select
      find(:all, :order => 'makes.name, models.name', :include => :make).collect { |i| [ "#{i.make.name} - #{i.name}", i.id ] }
    end
    
    def find_or_create_by_name_and_make_id( name, make_id )
      find( :first, :conditions => [ 'name like binary ? and make_id = ?', name, make_id ] ) || Model.create( :name => name, :make_id => make_id )
    end
    
  end
  
end
