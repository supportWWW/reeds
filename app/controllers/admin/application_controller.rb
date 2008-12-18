# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Admin::ApplicationController < ActionController::Base
  session :on
  include AuthenticatedSystem
  include ExceptionNotifiable
  before_filter :use_prototype
  before_filter :login_required
  
  layout "admin"
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3f96b1c8af7699d99ad8ccabc18e6740'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper_method :public_path
  
  protected

  def use_prototype
    @use_prototype = true
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
    @per_page ||= params[:per_page] || '50'
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

  def expire(dir)
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm_r(Dir.glob(cache_dir + "/#{dir}/*")) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Cache directory '#{cache_dir}/#{dir}' fully sweeped.")
  end

  def expire_home
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm(Dir.glob(cache_dir + "/index.html")) rescue Errno::ENOENT
    RAILS_DEFAULT_LOGGER.info("Home cache fully sweeped.")
  end
end
