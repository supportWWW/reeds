class MainController < ApplicationController
  helper :search
  
  def index
    @news_articles = NewsArticle.live.find(:all, :limit => 3)
  end

end
