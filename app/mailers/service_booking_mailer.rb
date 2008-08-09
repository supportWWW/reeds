class ServiceBookingMailer < ActionMailer::Base
  
  helper :application
  
  def booking( form )
    subject    'Reeds  - Service booking request'
    recipients ['joergd@pobox.com', form.email ]
    from        ActionMailer::Base.smtp_settings[:user_name]
    sent_on    Time.now
    body       :form => form
  end

end