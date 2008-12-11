class PagesController < ApplicationController

  caches_page :show
  
  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    if @page.nil?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

end
