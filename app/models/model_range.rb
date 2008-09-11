class ModelRange < ActiveRecord::Base
  validates_presence_of :name, :make_id
  validates_uniqueness_of :name, :scope => :make_id
  
  belongs_to :make
  has_many :new_vehicles, :dependent => :destroy
  
  class << self
    
    def for_select
      find( :all, :order => 'makes.name, model_ranges.name', :include => :make ).collect { |i| [ "#{i.make.name} - #{i.name}" , i.id] }
    end
    
  end
    
end
