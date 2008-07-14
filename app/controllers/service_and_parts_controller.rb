class ServiceAndPartsController < ApplicationController
  
  def book
    @form = ServiceBookingForm.new( params[:form] )
    if request.post? and @form.valid?
      flash[:notice] = 'Your message was successfully received'
      ServiceBookingMailer.deliver_booking( @form )
      redirect_to :action => 'book'      
    end
  end
  
end
