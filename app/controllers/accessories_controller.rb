class AccessoriesController < ApplicationController
  
  before_filter :login_required

  def destroy
    @accessory = Accessory.find( params[:id] )
    @accessory.destroy
    remove_with_fade "accessory_#{@accessory.id}"
  end

end
