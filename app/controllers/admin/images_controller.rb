class Admin::ImagesController < Admin::ApplicationController
  
  after_filter :expire_cache, :only => [:destroy]

  def destroy
    @image = Image.find( params[:id] )
    @image.destroy
    remove_with_fade "image_#{@image.id}"
  end
  
private

  def expire_cache
    expire("news_articles")
    expire("pages")
    expire("new_vehicles")
    expire("contact")
  end
end
