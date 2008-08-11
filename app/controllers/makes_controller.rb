class MakesController < ApplicationController
  
  before_filter :login_required
  
  # GET /makes
  # GET /makes.xml
  def index
    @makes = paginate( Make, :order => 'name' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @makes }
    end
  end

  # GET /makes/1
  # GET /makes/1.xml
  def show
    @make = Make.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @make }
    end
  end

  # GET /makes/new
  # GET /makes/new.xml
  def new
    @make = Make.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @make }
    end
  end

  # GET /makes/1/edit
  def edit
    @make = Make.find(params[:id])
  end

  # POST /makes
  # POST /makes.xml
  def create
    @make = Make.new(params[:make])

    respond_to do |format|
      if @make.save
        flash[:notice] = 'Make was successfully created.'
        format.html { redirect_to makes_url }
        format.xml  { render :xml => @make, :status => :created, :location => @make }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @make.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /makes/1
  # PUT /makes/1.xml
  def update
    @make = Make.find(params[:id])

    respond_to do |format|
      if @make.update_attributes(params[:make])
        flash[:notice] = 'Make was successfully updated.'
        format.html { redirect_to makes_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @make.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /makes/1
  # DELETE /makes/1.xml
  def destroy
    @make = Make.find(params[:id])
    @make.destroy

    respond_to do |format|
      format.html { redirect_to(makes_url) }
      format.xml  { head :ok }
    end
  end
end
