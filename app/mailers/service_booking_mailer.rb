class ServiceBookingMailer < ActionMailer::Base
  
  helper :application
  
  def booking( form )
    subject    'Reeds  - Service booking request'
    recipients ['joergd@pobox.com' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form
  end

end