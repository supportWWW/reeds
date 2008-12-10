class Admin::ClassifiedsController < Admin::ApplicationController

  after_filter :expire_cache, :only => [:update]

  # GET /classifieds/cyberstock
  # GET /classifieds/cyberstock.xml
  def cyberstock
    @classifieds = Cyberstock.all

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

private

  def expire_cache
    expire("classifieds")
  end
end
