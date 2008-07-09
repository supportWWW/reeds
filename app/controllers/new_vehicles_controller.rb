class NewVehiclesController < ApplicationController
  
  before_filter :login_required
  before_filter :load_page, :only => :index
  
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
    @new_vehicle = NewVehicle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @new_vehicle }
    end
  end

  # GET /new_vehicles/new
  # GET /new_vehicles/new.xml
  def new
    @new_vehicle = NewVehicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @new_vehicle }
    end
  end

  # GET /new_vehicles/1/edit
  def edit
    @new_vehicle = NewVehicle.find(params[:id])
  end

  # POST /new_vehicles
  # POST /new_vehicles.xml
  def create
    @new_vehicle = NewVehicle.new(params[:new_vehicle])

    respond_to do |format|
      if @new_vehicle.save
        flash[:notice] = 'The new vehicle was successfully created.'
        handle_nested
        format.html { redirect_to(@new_vehicle) }
        format.xml  { render :xml => @new_vehicle, :status => :created, :location => @new_vehicle }
      else
        handle_nested
        format.html { render :action => "new" }
        format.xml  { render :xml => @new_vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /new_vehicles/1
  # PUT /new_vehicles/1.xml
  def update
    @new_vehicle = NewVehicle.find(params[:id])

    respond_to do |format|
      if @new_vehicle.update_attributes(params[:new_vehicle])
        handle_nested
        flash[:notice] = 'The new nehicle was successfully updated.'
        format.html { redirect_to(@new_vehicle) }
        format.xml  { head :ok }
      else
        handle_nested
        format.html { render :action => "edit" }
        format.xml  { render :xml => @new_vehicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /new_vehicles/1
  # DELETE /new_vehicles/1.xml
  def destroy
    @new_vehicle = NewVehicle.find(params[:id])
    @new_vehicle.destroy

    respond_to do |format|
      format.html { redirect_to(new_vehicles_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def handle_nested
    handle_accessories
    handle_new_vehicle_variants
    handle_uploaded_data Image, :uploaded_images
    handle_uploaded_data Attachment, :uploaded_files
  end
  
  def handle_accessories
    handle_item :accessories
  end
  
  def handle_new_vehicle_variants
    handle_item :new_vehicle_variants
  end
  
  def handle_uploaded_data( model_class, key )
    if !params[key].blank? and !@new_vehicle.new_record?
      params[key].each_value do |f|
        unless f.blank?
          p "Running the attachment code for '#{model_class.name}' and '#{key}'"
          model_class.create!( :owner_id => @new_vehicle.id, :owner_type => @new_vehicle.class.name, :uploaded_data => f )
        end
      end
    end
  end
  
  def handle_item( key )
    unless params[ key ].blank?
      params[ key ].each_value do |a|
        unless a[:id].blank?
          item = @new_vehicle.send( key ).find( a[:id] )
          a.delete :id
          item.update_attributes a
        else
          item = @new_vehicle.send( key ).build( a )
          item.save unless @new_vehicle.new_record?
        end
      end
    end
  end
  
end
