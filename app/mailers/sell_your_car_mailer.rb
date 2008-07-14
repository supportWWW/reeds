class SellYourCarMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form )
    subject    'Reeds  - Sell your car client request'
    recipients ['mauricio.linhares@gmail.com', form.your_email ]
    from        ActionMailer::Base.smtp_settings[:user_name]
    sent_on    Time.now
    body       :form => form
  end

end
