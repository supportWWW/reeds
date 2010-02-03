class Classified < ActiveRecord::Base
  
  validates_presence_of :price_in_cents, :model_variant_id, :stock_code
  money :price
  

  belongs_to :model_variant
  
  belongs_to :model # denormalized for search
  belongs_to :make # denormalized for search

  belongs_to :branch

  before_validation :set_make_and_model
  has_permalink [:humanize, :stock_code] # needs to be after before_validation :set_make_and_model
  
  named_scope :available, lambda { { :conditions => ["removed_at is NULL AND (expires_on IS NULL OR expires_on > ?)", Date.today], :include => [:make, :model], :order => "makes.name, models.name, classifieds.price_in_cents" } }

  delegate :mead_mcgrouther_code, :to => :model_variant
  
  def self.with_photos
    classifieds = []
    Classified.available.each do |classified|
      classifieds << classified if classified.has_all_images?
    end
    classifieds
  end

  def self.no_photos(branch_id = nil)
    classifieds = []
    available = branch_id.nil? ? Classified.available : Classified.available.find(:all, :conditions => { :branch_id => branch_id })
    available.each do |classified|
      classifieds << classified if !classified.has_all_images?
    end
    classifieds
  end

  def cyberstock?
    kind_of?(Cyberstock)
  end

  def used_vehicle?
    kind_of?(UsedVehicle)
  end
  
  def humanize
    if make && model
      "#{make.common_name} #{model.common_name}"
    else
      ""
    end
  end
  
  def removed?
    !removed_at.nil?
  end
  
  def has_images?
    !images.empty?
  end

  def has_all_images?
    images.size == 3
  end
  
  # Default image
  def img_url
    filename = "#{reg_num}_1.jpg"
    File.exist?("#{RAILS_ROOT}/public/vehicles/#{filename}") ? "/vehicles/#{filename}" : ""
  end

  # Default image - used for Carfind for example
  def full_img_url
    @full_image_url ||= nil
    if @full_image_url.nil?
      filename = "#{reg_num}_1.jpg"
      @full_image_url = File.exist?("#{RAILS_ROOT}/public/vehicles/#{filename}") ? "http://www.reeds.co.za/vehicles/#{filename}" : ""
    end
    @full_image_url
  end
  
  def images
    return @imgs unless @imgs.nil?
    @imgs = []
    %w(1 2 3).each do |suffix|
      filename = "#{reg_num}_#{suffix}.jpg"
      if File.exist?("#{RAILS_ROOT}/public/vehicles/#{filename}")
        @imgs << "/vehicles/#{filename}"
      end
    end
    @imgs
  end

  # Fills up the array with placeholders if need be.
  def gallery_images
    imgs = images
    1.upto(3 - imgs.size) do |i|
      imgs << "/images/placeholder.png"
    end
    imgs
  end
  
  def missing_images
    imgs = []
    %w(1 2 3).each do |suffix|
      filename = "#{reg_num}_#{suffix}.jpg"
      if !File.exist?("#{RAILS_ROOT}/public/vehicles/#{filename}")
        imgs << suffix
      end
    end
    imgs
  end
  
private

  # denormalization for search
  def set_make_and_model
    if model_variant_id
      variant = ModelVariant.find(self.model_variant_id)
      self.model = variant.model
      self.make = variant.model.make
    end
  end

end
