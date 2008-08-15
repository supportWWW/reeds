class ContactController < ApplicationController

  def index
    @branches = Branch.find(:all, :order => "name", :include => [:salespeople])
  end
  
  def sell_your_car
    @form = SellMyCarForm.new( params[:sell_your_car_form] )
    if request.post? and @form.valid?
      flash[:notice] = 'We received your message and will get in contact shortly'
      SellYourCarMailer.deliver_client_request @form
      redirect_to :action => 'sell_your_car'
    elsif request.post?
      flash.now[:error]= 'You must fill the required fields'
    end
  end
  
  def load_models
    unless params[:make_id].blank?
      @models = Model.find_all_by_make_id( params[:make_id] ).collect { |m| [ m.name, m.id ] }
      @models.insert( 0, [ 'Select a model...', '' ] )
      render :update do |page|
        page.replace_html( 'model_id', options_for_select( @models ) )
        page.replace_html( 'sell_your_car_form_model_variant_id', '<option value="">Select a model first</option>' )
        page.hide( 'models_spinner' )
      end      
    end
  end
  
  def load_model_variants
    unless params[:model_id].blank?
      @model_variants = ModelVariant.find_all_by_model_id( params[:model_id] ).collect { |m| [ m.year, m.id ] }
      render :update do |page|
        page.replace_html( 'sell_your_car_form_model_variant_id', options_for_select( @model_variants ) )
        page.hide( 'model_variants_spinner' )
      end
    end
  end
  
  
end
