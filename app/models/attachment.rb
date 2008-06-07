class Attachment < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  has_attachment :storage => :file_system, :path_prefix => 'public/uploaded_files'
  
end
