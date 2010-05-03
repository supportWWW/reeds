class Admin::ClassifiedsController < Admin::ApplicationController

  after_filter :expire_cache, :only => [:update, :destroy]
  helper "admin/stats"
  # GET /classifieds/cyberstock
  # GET /classifieds/cyberstock.xml
  def index

    #the following sort order items are sorted by the model
    unless params[:id].nil?
      case true
        when params[:id] == "model"
          Classified.set_order_var( " makes.name , models.name ASC ")
          @classifieds = Classified.available_sorted
        when params[:id] == "stock_code"
          Classified.set_order_var( params[:id] << " ASC")
          @classifieds = Classified.available_sorted
        when params[:id] == "price_in_cents"
          Classified.set_order_var( params[:id] << " DESC")
          @classifieds = Classified.available_sorted
        when params[:id] == "colour"
          Classified.set_order_var( params[:id]  << " ASC")
          @classifieds = Classified.available_sorted
        when params[:id] == "days_in_stock"
          Classified.set_order_var( params[:id] << " DESC " )
          @classifieds = Classified.available_sorted
        when params[:id] == "mileage"
          Classified.set_order_var( params[:id] << " DESC " )
          @classifieds = Classified.available_sorted
        when params[:id] == "views" ||  params[:id] == "forms_sent" || params[:id] == "conversions"
        @classifieds = Classified.available
      end
    else
      Classified.set_order_var("")
      @classifieds = Classified.available
    end


    #the following params[:id] values cause the array to be sorted as the values
    # to be sorted are added to the array programmatically
    unless params[:id].nil?
        case true
          when params[:id] == "views" 
            @classifieds.sort! {|a, b|  a.stats_count <=> b.stats_count}
            @classifieds.reverse!
          when params[:id] == "forms_sent"
            @classifieds.sort! {|a, b|  a.form_count <=> b.form_count}
            @classifieds.reverse!
          when params[:id] == "conversions"
            @classifieds.sort! {|a, b|  a.conversions.to_f <=> b.conversions.to_f}
            @classifieds.reverse!
      end
    end

    #@classifieds.reverse!

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  def sort_by
    #Classified.set_order_var(" classifieds.price_in_cents ,")
    #defaults makes.name, models.name, classifieds.price_in_cents
    #Classified.set_order_var(" classifieds.colour ,")
    #Classified.set_order_var(" classifieds.mileage ,")
    #Classified.set_order_var(" classifieds.days_in_stock ,")

    @classifieds = Classified.available

    #if param[:whateva] == "views"
      @classifieds.sort! {|a, b|  a.stats_count <=> b.stats_count}
    #end

    #if order needs to be reversed ?
      @classifieds.reverse!
    #end

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
