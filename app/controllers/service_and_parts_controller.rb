class ServiceAndPartsController < ApplicationController
  
  def book
    @form = ServiceBookingForm.new( params[:form] )
    @success = false
    if request.post? and @form.valid?
      flash[:notice] = 'Your message was successfully received'
      ServiceBookingMailer.deliver_booking( @form )
      @success = true

      respond_to do |format|
        format.html { redirect_to :action => 'book' }
        format.js
      end
    end
    
  end
  
end
