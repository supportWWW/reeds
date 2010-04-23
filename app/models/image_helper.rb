module ImageHelper
	
  def uploaded_image
    image || self.build_image
  end
	
  def uploaded_data=(data)
    unless data.blank?
      _image  = uploaded_image
      _image.uploaded_data = data
      self[:image] = _image
    end
  end
  
  def has_image?
    !image.nil? && !image.new_record?
  end
  
  def uploaded_data
    nil
  end

  def set_owner_to_image
    if image
      image.owner = self
      image.save
    end
  end
	
  class << self
		
    def included( base )
      base.has_one :image, :as => :owner, :dependent => :destroy
      base.after_save :set_owner_to_image
    end
		
  end
	
end