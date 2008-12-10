class Admin::AccessoriesController < Admin::ApplicationController
  
  after_filter :expire_cache, :only => [:destroy]

  def destroy
    @accessory = Accessory.find( params[:id] )
    @accessory.destroy
    remove_with_fade "accessory_#{@accessory.id}"
  end

private

  def expire_cache
    expire("new_vehicles")
  end
end
