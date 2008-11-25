class SpecialsController < ApplicationController

  # GET /specials
  # GET /specials.xml
  def index
    @specials = Special.find(:all, :order => 'created_at')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specials }
    end
  end

  # GET /specials/1
  # GET /specials/1.xml
  def show
    @special = Special.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @special }
    end
  end

end
