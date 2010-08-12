class ContactController < ApplicationController

  caches_page :index
  
  def index
    @branches = Branch.find(:all, :order => "name", :include => [:salespeople])
  end
  
  def sell_your_car
    @form = SellMyCarForm.new( params[:sell_your_car_form] )
    @make = params[:sell_your_car_form_make_id] ? Make.find(params[:sell_your_car_form_make_id]) : nil
    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your message and will get in contact shortly'
      SellYourCarMailer.deliver_client_request @form
      redirect_to :action => 'sell_your_car'
    elsif request.post?
      flash.now[:error]= 'You must fill the required fields'
    end
  end
  
  def find_car
    @form = FindCarForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your message and will get in contact shortly'
      FindCarMailer.deliver_client_request @form, get_referrals
      @success = true
    elsif request.post?
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end
  
  def load_models
    if params[:make_id]
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, [ 'Select a model...', '' ] )
    else
      redirect_to :controller => "contact"
    end
  end
  
  def load_model_variants
    if params[:model_id]
      @model_variants = ModelVariant.find_all_by_model_id( params[:model_id] ).collect { |m| [ m.year, m.id ] }.uniq
    else
      redirect_to :controller => "contact"
    end
  end

  def used_vehicle_enquiry
    @form = UsedVehicleEnquiryForm.new( params[:form] )
    #insert record into form_submit for FormSubmit table for stats
    @form_submit = FormSubmit.new
    @form_submit.form_name = "used_vehicle_enquiry"
    @form_submit.product_id = @form.classified_id
    @form_submit.created_at = Time.now
    @form_submit.save

	  recipient = params[:form][:email]
	  subject = "We thank you for your enquiry"
    VehicleEnquiryMailer.deliver_autoresponder(recipient, subject)

    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your enquiry and will get in contact shortly'
      VehicleEnquiryMailer.deliver_used @form, get_referrals
      @success = true
    elsif request.post?
      @success = false
    end


    respond_to do |format|
      format.js
    end
  end

  def new_vehicle_enquiry
    @form = NewVehicleEnquiryForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your enquiry and will get in contact shortly'
      VehicleEnquiryMailer.deliver_neww @form, get_referrals
      @success = true
    elsif request.post?
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  def new_vehicle_book_test_drive
    @form = BookTestDriveForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:public_notice] = 'We received your enquiry and will get in contact shortly'
      BookTestDriveMailer.deliver_neww @form, get_referrals
      @success = true
    elsif request.post?
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end
  
  def callback
    @form = CallbackForm.new( params[:form] )
    if request.post? and @form.valid?
      msg = "REEDS: Please call #{@form.first} #{@form.last} on #{@form.phone} re #{@form.vehicle}."
      branch = Branch.find(@form.branch_id)
      @success = false
      salespeople_names = []
      branch.salespeople.sms_callbacks.each do |salesperson|
        logger.info("Callback: #{salesperson.name}")
        if phone = salesperson.phone_for_sms
          ret = HugeSms.deliver(phone, msg)
          if ret
            @success = true
            salespeople_names << salesperson.name
          end
        end
      end
      flash[:public_notice] = 'We received your message and will get in contact shortly'
      CallbackMailer.deliver_requested(@form, salespeople_names, get_referrals)
      
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
