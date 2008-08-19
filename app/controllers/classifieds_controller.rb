class ClassifiedsController < ApplicationController

  helper :search
  
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
    @classified = Classified.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classified }
    end
  end

end
