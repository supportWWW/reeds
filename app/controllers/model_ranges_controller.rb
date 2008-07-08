class ModelRangesController < ApplicationController
  
  before_filter :login_required
  
  # GET /model_ranges
  # GET /model_ranges.xml
  def index
    @model_ranges = paginate( ModelRange, :order => 'makes.name, model_ranges.name', :include => :make )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @model_ranges }
    end
  end

  # GET /model_ranges/1
  # GET /model_ranges/1.xml
  def show
    @model_range = ModelRange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model_range }
    end
  end

  # GET /model_ranges/new
  # GET /model_ranges/new.xml
  def new
    @model_range = ModelRange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model_range }
    end
  end

  # GET /model_ranges/1/edit
  def edit
    @model_range = ModelRange.find(params[:id])
  end

  # POST /model_ranges
  # POST /model_ranges.xml
  def create
    @model_range = ModelRange.new(params[:model_range])

    respond_to do |format|
      if @model_range.save
        flash[:notice] = 'Model Range was successfully created.'
        format.html { redirect_to( model_ranges_path ) }
        format.xml  { render :xml => @model_range, :status => :created, :location => @model_range }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /model_ranges/1
  # PUT /model_ranges/1.xml
  def update
    @model_range = ModelRange.find(params[:id])

    respond_to do |format|
      if @model_range.update_attributes(params[:model_range])
        flash[:notice] = 'Model Range was successfully updated.'
        format.html { redirect_to( model_ranges_path ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /model_ranges/1
  # DELETE /model_ranges/1.xml
  def destroy
    @model_range = ModelRange.find(params[:id])
    @model_range.destroy

    respond_to do |format|
      format.html { redirect_to(model_ranges_url) }
      format.xml  { head :ok }
    end
  end
end
