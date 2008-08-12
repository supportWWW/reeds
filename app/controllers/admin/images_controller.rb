class Admin::ImagesController < Admin::ApplicationController
  
  def destroy
    @image = Image.find( params[:id] )
    @image.destroy
    remove_with_fade "image_#{@image.id}"
  end
  
end
