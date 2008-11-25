class Image < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  has_attachment :storage => :file_system, :path_prefix => 'public/uploaded_images', :content_type => :image, :thumbnails => { :thumb => "200x200!" }

  validates_presence_of :filename, :content_type
  
  before_save :set_name
  
  def set_name
    if name.blank?
      self[:name] = filename
    end
  end
  
  
end
