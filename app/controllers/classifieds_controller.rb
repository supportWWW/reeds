class ClassifiedsController < ApplicationController

  # GET /classifieds
  # GET /classifieds.xml
  def index
    @classifieds = Classified.find(:all)

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

end
