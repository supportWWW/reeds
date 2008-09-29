class NewVehiclesController < ApplicationController
  
  before_filter :load_page, :only => :index
  
  skip_before_filter :use_prototype, :only => :show
  
  # GET /new_vehicles
  # GET /new_vehicles.xml
  def index
    @new_vehicles = paginate( NewVehicle, :order => 'created_at desc' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @new_vehicles }
    end
  end

  # GET /new_vehicles/1
  # GET /new_vehicles/1.xml
  def show
    @new_vehicle = NewVehicle.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @new_vehicle }
    end
  end

end
