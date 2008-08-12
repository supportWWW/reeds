class PagesController < ApplicationController

  before_filter :load_page, :only => :index
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = paginate( Page, :order => 'title' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

end
