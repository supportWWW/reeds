# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Admin::ApplicationController < ApplicationController
  before_filter :login_required
  
  layout "admin"

  def load_page
    @page ||= params[:page] || '1'
    @per_page ||= params[:per_page] || '50'
  end
  
end
