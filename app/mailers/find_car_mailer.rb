class FindCarMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form )
    subject    'Reeds  - Find car request'
    recipients ['joergd@pobox.com', form.email ]
    from        ActionMailer::Base.smtp_settings[:user_name]
    sent_on    Time.now
    body       :form => form
  end

end
