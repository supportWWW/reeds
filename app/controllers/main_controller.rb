class MainController < ApplicationController
  helper :search
  
  def index
    @news_articles = NewsArticle.paginate_current
  end

end
