class Admin::PromotionBoxesController < Admin::ApplicationController
  # GET /promotion_boxes
  # GET /promotion_boxes.xml
  def index
    @promotion_boxes = PromotionBox.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @promotion_boxes }
    end
  end

  # GET /promotion_boxes/1
  # GET /promotion_boxes/1.xml
  def show
    @promotion_box = PromotionBox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @promotion_box }
    end
  end

  # GET /promotion_boxes/new
  # GET /promotion_boxes/new.xml
  def new
    @promotion_box = PromotionBox.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @promotion_box }
    end
  end

  # GET /promotion_boxes/1/edit
  def edit
    @promotion_box = PromotionBox.find(params[:id])
  end

  # POST /promotion_boxes
  # POST /promotion_boxes.xml
  def create
    @promotion_box = PromotionBox.new(params[:promotion_box])

    respond_to do |format|
      if @promotion_box.save
        flash[:notice] = 'PromotionBox was successfully created.'
        format.html { redirect_to admin_promotion_boxes_path }
        format.xml  { render :xml => @promotion_box, :status => :created, :location => @promotion_box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @promotion_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /promotion_boxes/1
  # PUT /promotion_boxes/1.xml
  def update
    @promotion_box = PromotionBox.find(params[:id])

    respond_to do |format|
      if @promotion_box.update_attributes(params[:promotion_box])
        flash[:notice] = 'PromotionBox was successfully updated.'
        format.html { redirect_to admin_promotion_boxes_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @promotion_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /promotion_boxes/1
  # DELETE /promotion_boxes/1.xml
  def destroy
    @promotion_box = PromotionBox.find(params[:id])
    @promotion_box.destroy

    respond_to do |format|
      format.html { redirect_to(admin_promotion_boxes_url) }
      format.xml  { head :ok }
    end
  end
end
