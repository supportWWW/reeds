class AccessoriesController < ApplicationController
  
  def destroy
    @accessory = Accessory.find( params[:id] )
    @accessory.destroy
    remove_with_fade "accessory_#{@accessory.id}"
  end

end
