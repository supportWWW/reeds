class ServiceAndPartsController < ApplicationController
  
  def book
    @form = ServiceBookingForm.new( params[:form] )
    @success = false
    if request.post? and @form.valid?
      flash[:public_notice] = 'Thanks for your service booking request.  We will contact you soon to confirm this booking'
      ServiceBookingMailer.deliver_booking( @form )
      @success = true

      respond_to do |format|
        format.html
      end
    end
    
  end
  
end
