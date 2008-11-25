class Admin::SpecialsController < Admin::ApplicationController

  before_filter :load_page, :only => :index
  

  # GET /specials
  # GET /specials.xml
  def index
    @specials = paginate( Special, :order => 'created_at' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specials }
    end
  end

  # GET /specials/1
  # GET /specials/1.xml
  def show
    @special = Special.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @special }
    end
  end

  # GET /specials/new
  # GET /specials/new.xml
  def new
    @special = Special.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @special }
    end
  end

  # GET /specials/1/edit
  def edit
    @special = Special.find(params[:id])
  end

  # POST /specials
  # POST /specials.xml
  def create
    @special = Special.new(params[:special])

    respond_to do |format|
      if @special.save
        flash[:notice] = 'Special was successfully created.'
        format.html { redirect_to admin_special_path(@special) }
        format.xml  { render :xml => @special, :status => :created, :location => @special }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @special.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /specials/1
  # PUT /specials/1.xml
  def update
    @special = Special.find(params[:id])

    respond_to do |format|
      if @special.update_attributes(params[:special])
        flash[:notice] = 'Special was successfully updated.'
        format.html { redirect_to admin_special_path(@special) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @special.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /specials/1
  # DELETE /specials/1.xml
  def destroy
    @special = Special.find(params[:id])
    @special.destroy

    respond_to do |format|
      format.html { redirect_to(admin_specials_url) }
      format.xml  { head :ok }
    end
  end
end
