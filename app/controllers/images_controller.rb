class ImagesController < ApplicationController
  
  before_filter :login_required
  
  def destroy
    @image = Image.find( params[:id] )
    @image.destroy
    remove_with_fade "image_#{@image.id}"
  end
  
end
