# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  self.allow_forgery_protection = false

  include ExceptionNotifiable
  before_filter :use_jquery
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3f96b1c8af7699d99ad8ccabc18e6740'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper :search
  helper_method :public_path
  
  protected

  def use_prototype
    @use_prototype = true
  end

  def use_jquery
    @use_jquery = true
  end
  rescue_from ActionController::InvalidAuthenticityToken do
   reset_session
   redirect_to(login_path)
end
  def public_path
    if request.port == 80
      "http://#{request.domain}"
    else
      "http://#{request.domain}:#{request.port.to_s}"
    end
  end
  
  def load_page
    @page ||= params[:page] || '1'
    @per_page ||= params[:per_page] || '10'
  end
  
  def paginate( model, options = {} )
    load_page
    model.paginate( options.merge( {:page => @page, :per_page => @per_page} ) )
  end
  
  def remove_with_fade( id, duration = 2, delay = 3 )
    render :update do |page|
      page.visual_effect( :fade, id, { :duration => duration } )
      page.delay delay do
        page.remove id
      end
    end    
  end
  
end
