class ModelVariant < ActiveRecord::Base

  belongs_to :model
  has_many :classifieds
  
  validates_presence_of :year, :model_id, :mead_mcgrouther_code
  validates_uniqueness_of :year, :scope => :mead_mcgrouther_code
  
  def to_s
    "#{model.make.name} - #{model.name} - #{year}"
  end
  
  class << self 
    
    def find_with_model_and_make
      find( :all, :conditions => 'model_variants.model_id = models.id and models.make_id = makes.id', :order => 'makes.name asc, models.name asc, model_variants.year desc', :include => [ :model => :author ]  )
    end
    
    def find_or_create_for( make_name, model_name, mm_code, year )
      make  = Make.find_or_create_by_name( make_name.strip )
      raise ActiveRecord::RecordNotSaved, make.errors.inspect if make.new_record?
      model = Model.find_or_create_by_name_and_make_id( model_name.strip, make.id )
      raise ActiveRecord::RecordNotSaved, model.errors.inspect if model.new_record?
      model_variant = ModelVariant.find_or_create_by_year_and_model_id_and_mead_mcgrouther_code( year.strip, model.id, mm_code.strip )
      raise ActiveRecord::RecordNotSaved, model_variant.errors.inspect if model_variant.new_record?
      model_variant
    end
    
  end
  
  
end
