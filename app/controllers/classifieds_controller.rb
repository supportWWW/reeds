class ClassifiedsController < ApplicationController

  caches_page :show
  
  # GET /classifieds
  # GET /classifieds.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => "" }
    end
  end

  # GET /classifieds/1
  # GET /classifieds/1.xml
  def show
    @classified = Classified.find_by_permalink(params[:id])

    if @classified.nil?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classified }
    end
  end

end
