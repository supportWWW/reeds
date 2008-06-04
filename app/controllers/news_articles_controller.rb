class NewsArticlesController < ApplicationController
  # GET /news_articles GET /news_articles.xml
  
  before_filter :login_required, :except => :show
  before_filter :load_news_article, :only => [ :show, :new, :edit, :update, :destroy ]
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

  # GET /news_articles/new GET /news_articles/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news_article }
    end
  end

  # GET /news_articles/1/edit
  def edit

  end

  # POST /news_articles POST /news_articles.xml
  def create
    @news_article = NewsArticle.new(params[:news_article])

    respond_to do |format|
      if @news_article.save
        flash[:notice] = 'NewsArticle was successfully created.'
        format.html { redirect_to(@news_article) }
        format.xml  { render :xml => @news_article, :status => :created, :location => @news_article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news_articles/1 PUT /news_articles/1.xml
  def update
    respond_to do |format|
      if @news_article.update_attributes(params[:news_article])
        flash[:notice] = 'NewsArticle was successfully updated.'
        format.html { redirect_to(@news_article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news_articles/1 DELETE /news_articles/1.xml
  def destroy
    @news_article.destroy

    respond_to do |format|
      format.html { redirect_to(news_articles_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def load_news_article
    if params[:id].blank?
      @news_article = NewsArticle.new
    else
      @news_article = NewsArticle.find_by_title_permalink( params[:id] )
    end
  end
  
end
