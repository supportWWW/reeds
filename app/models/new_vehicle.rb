class NewVehicle < ActiveRecord::Base

  belongs_to :model_range
  has_many :images, :as => :owner, :dependent => :destroy
  has_many :attachments, :as => :owner, :dependent => :destroy
  has_many :new_vehicle_variants, :dependent => :destroy
  has_many :accessories, :dependent => :destroy
  
  validates_presence_of :model_range_id, :year
  
  named_scope :enabled, :conditions => { :enabled => true }, :include => { :model_range => :make }

  delegate :make, :to => :model_range
  delegate :humanize, :to => :model_range
  
  class << self
    
    def for_select
      enabled(:all, :order => 'makes.name, model_ranges.name').collect { |i| [ "#{i.humanize} - #{i.year}" , i.id] }
    end
    
  end
end
