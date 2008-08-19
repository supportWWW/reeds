class Admin::ClassifiedsController < Admin::ApplicationController

  # GET /classifieds
  # GET /classifieds.xml
  def index
    @classifieds = Classified.cyberstock.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/1
  # GET /classifieds/1.xml
  def show
    @classified = Classified.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classified }
    end
  end

  # GET /classifieds/new
  # GET /classifieds/new.xml
  def new
    @classified = Classified.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classified }
    end
  end

  # GET /classifieds/1/edit
  def edit
    @classified = Classified.find(params[:id])
  end

  # POST /classifieds
  # POST /classifieds.xml
  def create
    @classified = Classified.new(params[:classified])

    respond_to do |format|
      if @classified.save
        flash[:notice] = 'Classified was successfully created.'
        format.html { redirect_to(admin_classified_path(@classified)) }
        format.xml  { render :xml => @classified, :status => :created, :location => @classified }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classified.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /classifieds/1
  # PUT /classifieds/1.xml
  def update
    @classified = Classified.find(params[:id])

    respond_to do |format|
      if @classified.update_attributes(params[:classified])
        flash[:notice] = 'Classified was successfully updated.'
        format.html { redirect_to(admin_classified_path(@classified)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classified.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classifieds/1
  # DELETE /classifieds/1.xml
  def destroy
    @classified = Classified.find(params[:id])
    @classified.destroy

    respond_to do |format|
      format.html { redirect_to(admin_classifieds_path) }
      format.xml  { head :ok }
    end
  end

  def load_models
    unless params[:make_id].blank?
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, ['Select a model...', ''] )
    else
      @models = [['Select a model...', '']]
    end
    render :update do |page|
      page.replace_html( 'model_id', options_for_select( @models ) )
      page.replace_html( 'classified_model_variant_id', '<option value="">Select a model first</option>' )
      page.hide( 'models_spinner' )
    end      
  end
  
  def load_model_variants
    unless params[:model_id].blank?
      @model_variants = ModelVariant.find_all_by_model_id( params[:model_id] ).collect { |m| [ m.year, m.id ] }
      render :update do |page|
        page.replace_html( 'classified_model_variant_id', options_for_select( @model_variants ) )
        page.hide( 'model_variants_spinner' )
      end
    end
  end
  
end
