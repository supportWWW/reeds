class ModelVariantsController < ApplicationController

  before_filter :login_required

  # GET /model_variants
  # GET /model_variants.xml
  def index
    @model_variants = paginate( ModelVariant, :include => :model, :order => 'models.name, model_variants.mead_mcgrouther_code' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @model_variants }
    end
  end

  # GET /model_variants/1
  # GET /model_variants/1.xml
  def show
    @model_variant = ModelVariant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model_variant }
    end
  end

  # GET /model_variants/new
  # GET /model_variants/new.xml
  def new
    @model_variant = ModelVariant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model_variant }
    end
  end

  # GET /model_variants/1/edit
  def edit
    @model_variant = ModelVariant.find(params[:id])
  end

  # POST /model_variants
  # POST /model_variants.xml
  def create
    @model_variant = ModelVariant.new(params[:model_variant])

    respond_to do |format|
      if @model_variant.save
        flash[:notice] = 'ModelVariant was successfully created.'
        format.html { redirect_to(@model_variant) }
        format.xml  { render :xml => @model_variant, :status => :created, :location => @model_variant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model_variant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /model_variants/1
  # PUT /model_variants/1.xml
  def update
    @model_variant = ModelVariant.find(params[:id])

    respond_to do |format|
      if @model_variant.update_attributes(params[:model_variant])
        flash[:notice] = 'ModelVariant was successfully updated.'
        format.html { redirect_to(@model_variant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model_variant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /model_variants/1
  # DELETE /model_variants/1.xml
  def destroy
    @model_variant = ModelVariant.find(params[:id])
    @model_variant.destroy

    respond_to do |format|
      format.html { redirect_to(model_variants_url) }
      format.xml  { head :ok }
    end
  end
end
