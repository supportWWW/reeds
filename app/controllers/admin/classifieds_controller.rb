class Admin::ClassifiedsController < Admin::ApplicationController

  after_filter :expire_cache, :only => [:update, :destroy]
  helper "admin/stats"
  # GET /classifieds/cyberstock
  # GET /classifieds/cyberstock.xml
  def index
    @classifieds = Classified.available

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/1
  def show
    @classified = Classified.find(params[:id])
    stats = Stat.find(:all, :select => "date, count(id) as total", :conditions => ["parent_type = :parent_type AND parent_id = :parent_id AND date BETWEEN :start and :end", { :parent_type => "Classified", :parent_id => @classified.id, :start => (Time.zone.now.to_date - 16.days), :end => Time.zone.now.to_date }], :group => [:date])
    last_few_days = {}
    16.downto(0) do |days_ago|
      last_few_days.merge!({ days_ago => 0 })
    end
    stats = stats.inject(last_few_days) { |memo, stat| memo.merge!({ (Time.zone.now.to_date - stat.date).to_i => stat.total.to_i }) }
    @stats = stats.sort.map { |stat| stat[1] }
    @total_stats = Stat.count(:conditions => ["parent_type = :parent_type AND parent_id = :parent_id", { :parent_type => "Classified", :parent_id => @classified.id }])
  end

  # GET /classifieds/cyberstock
  # GET /classifieds/cyberstock.xml
  def cyberstock
    @classifieds = Cyberstock.live

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/expired
  # GET /classifieds/expired.xml
  def expired
    @classifieds = Cyberstock.expired.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/with_photo
  # GET /classifieds/with_photo.xml
  def with_photo
    @classifieds = Classified.with_photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/no_photo
  # GET /classifieds/no_photo.xml
  def no_photo
    @classifieds = Classified.no_photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/1/edit
  def edit
    @classified = Classified.find(params[:id])
  end

  # PUT /classifieds/1
  # PUT /classifieds/1.xml
  def update
    @classified = Classified.find(params[:id])

    respond_to do |format|
      if @classified.update_attributes(params[:classified])
        flash[:notice] = 'Cyberstock was successfully updated.'
        format.html { redirect_to(cyberstock_admin_classifieds_path) }
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
      format.html { redirect_to(cyberstock_admin_classifieds_path) }
      format.xml  { head :ok }
    end
  end

private

  def expire_cache
    expire("classifieds")
  end
end
