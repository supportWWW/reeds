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
  
  def enquire
    @form = SpecialsForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:notice] = 'We received your message and will get in contact shortly'
      SpecialsMailer.deliver_client_request @form
      @success = true
    elsif request.post?
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

end
