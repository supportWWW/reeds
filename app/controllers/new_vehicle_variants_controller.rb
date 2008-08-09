class NewVehicleVariantsController < ApplicationController
  
  before_filter :login_required

  def destroy
    @new_vehicle_variant = NewVehicleVariant.find( params[:id] )
    @new_vehicle_variant.destroy
    remove_with_fade "new_vehicle_variant_#{@new_vehicle_variant.id}"
  end

end
