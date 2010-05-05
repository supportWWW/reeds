class NewVehiclesController < ApplicationController

  caches_page :show, :index
  
  skip_before_filter :use_prototype, :only => :show
  
  # GET /new_vehicles
  # GET /new_vehicles.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => "" }
    end
  end

  # GET /new_vehicles/1
  # GET /new_vehicles/1.xml
  def show
    @new_vehicle = NewVehicle.find_by_permalink(params[:id])
    if @new_vehicle.nil?
      if @new_vehicle.description != ""
        @new_vehicle.description = @new_vehicle.permalink
      end
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404

      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @new_vehicle }
    end
  end

end
