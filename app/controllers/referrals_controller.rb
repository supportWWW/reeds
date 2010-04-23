class ReferralsController < ApplicationController

  def visit
    @referral = Referral.find(params[:id])
    if session[:visits].blank?
      session[:visits] = @referral.id.to_s
      create_visit
    elsif !(session[:visits].split(',').collect { |v| v.strip }.include?( @referral.id.to_s ))
      create_visit
      session[:visits] += ",#{@referral.id}"
    else
      flash[:debug] = 'User clicked more than once on the same link '
    end
    
    logger.info session.inspect
    
    respond_to do |format|
      format.html { redirect_to @referral.redirect_to }
      format.jpeg do |format|
        send_data get_image, :disposition => 'inline', :type => 'image/jpeg'
      end
    end
    
  end
  
private
  
  def get_image
    IO.read( "#{RAILS_ROOT}/public/images/blank.jpeg" )
  end
  
  def create_visit
    @referral.visits.create( :referer => request.headers['Referer'], :user_agent => request.headers['User-Agent'], :remote_ip => request.remote_ip )
  end
  
end
