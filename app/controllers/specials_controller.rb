class SpecialsController < ApplicationController

  caches_page :show, :index
  
  # GET /specials
  # GET /specials.xml
  def index
    @specials = Special.enabled

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specials }
    end
  end

  # GET /specials/1
  # GET /specials/1.xml
  def show
    @special = Special.find(params[:id])

    if @special.nil?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @special }
    end
  end
  
  def enquire
    @form = SpecialsForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your message and will get in contact shortly'
      SpecialsMailer.deliver_client_request @form, get_referrals
      @success = true
    elsif request.post?
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  private

    def get_referrals
      referrals = []
      unless session[:visits].blank?
        referral_ids = session[:visits].split(",").map(&:to_i)
        referrals = referral_ids.map { |referral_id| Referral.find(referral_id).name }
      end
      return referrals
    end

end
