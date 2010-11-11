class NewslettersController < ApplicationController
  def subscribe
    if(request[:format].nil?)

    elsif
    redirect_to :action=>'subscribe'
    end
    
  end

  def unsubscribed
  end

  def confirmation
  end

end
