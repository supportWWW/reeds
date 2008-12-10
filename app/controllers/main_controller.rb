class MainController < ApplicationController
  helper :search
  
  caches_page :index
  
  def index
    @news_articles = NewsArticle.live.find(:all, :limit => 3)
  end

end
