class Attachment < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  has_attachment :storage => :file_system, :path_prefix => 'public/uploaded_files'
  
  before_save :set_name
  
  def set_name
    if name.blank?
      self[:name] = filename
    end
  end
  
end
