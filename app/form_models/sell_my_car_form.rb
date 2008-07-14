class SellMyCarForm < ActiveRecord::BaseWithoutTable

  column :model_variant_id, :integer
  column :has_full_service_history, :boolean
  column :interested_in_buying, :boolean
  column :vehicle_details, :string
  column :color, :string
  column :your_name, :string
  column :your_email, :string
  column :your_contact_phone_number, :string
  
  belongs_to :model_variant
  
  validates_presence_of :vehicle_details, :color, :your_name, :your_email, :your_contact_phone_number
  
end