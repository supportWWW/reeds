class CustomController < ApplicationController
  helper :search
  
  caches_page :cruze
  
  def cruze
  end

  def spark
  end
end
