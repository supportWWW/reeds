class NewsArticlesController < ApplicationController
  # GET /news_articles GET /news_articles.xml
  
  before_filter :load_news_article, :only => [ :show ]
  before_filter :load_page, :only => :index
  
  def index
    @news_articles = paginate( NewsArticle, :order => 'publish_at desc', :include => :category )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news_articles }
    end
  end

  # GET /news_articles/1 GET /news_articles/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news_article }
    end
  end

protected
  
  def load_news_article
    if params[:id].blank?
      @news_article = NewsArticle.new
    else
      @news_article = NewsArticle.find( params[:id] )
    end
  end
  
end
