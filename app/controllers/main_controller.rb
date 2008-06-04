class MainController < ApplicationController
  
  def index
    @news_articles = NewsArticle.paginate_current
  end

end
