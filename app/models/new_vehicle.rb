class NewVehicle < ActiveRecord::Base

  belongs_to :model_range
  has_many :images, :as => :owner, :dependent => :destroy
  has_many :attachments, :as => :owner, :dependent => :destroy, :order => "created_at ASC" do
    def brochure
      find(:first)
    end
  end
  has_many :new_vehicle_variants, :order => "price_in_cents ASC", :dependent => :destroy
  has_many :accessories, :dependent => :destroy
  
  validates_presence_of :model_range_id, :year
  
  named_scope :enabled, :conditions => { :enabled => true }, :include => { :model_range => :make }

  delegate :make, :to => :model_range
  delegate :name, :to => :model_range
  delegate :humanize, :to => :model_range
  
  has_permalink :humanize
  
  # Fills up the array with placeholders if need be.
  def gallery_images
    imgs = []
    images.each do |image|
      imgs << image.public_filename(:medium)
    end
    1.upto(6 - imgs.size) do |i|
      imgs << "/images/placeholder.png"
    end
    imgs
  end

  class << self
    
    def for_select
      enabled(:all, :order => 'makes.name, model_ranges.name').collect { |i| [ "#{i.humanize} - #{i.year}" , i.id] }
    end

    def find_with_permalink( *args )
      if args.size == 1 and !args.first.kind_of?(Symbol) and args.first.to_i.to_s != args.first.to_s
        find_without_permalink :first, :conditions => { :permalink => args.first }
      else
        find_without_permalink( *args )
      end
    end
    
    alias_method_chain :find, :permalink
    
  end
end
