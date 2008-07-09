class NewVehicle < ActiveRecord::Base

  belongs_to :model_range
  has_many :images, :as => :owner
  has_many :attachments, :as => :owner
  has_many :new_vehicle_variants, :dependent => :destroy
  has_many :accessories, :dependent => :destroy
  
  validates_presence_of :model_range_id, :year
  
end
