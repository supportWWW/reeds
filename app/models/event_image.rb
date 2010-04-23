class EventImage < Image
  has_attachment :storage => :file_system, :path_prefix => 'public/uploaded_images', :content_type => :image, :thumbnails => { :thumb => "120x", :gallery => '620x' }

  acts_as_list :scope => :owner
end
