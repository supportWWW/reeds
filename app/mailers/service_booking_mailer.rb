class ServiceBookingMailer < ActionMailer::Base
  
  helper :application
  
  def booking( form )
    subject    'Reeds  - Service booking request'
    recipients ['rv@imaginet.co.za', 'leonap@reeds.co.za', 'direct@reeds.co.za' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form
  end

end