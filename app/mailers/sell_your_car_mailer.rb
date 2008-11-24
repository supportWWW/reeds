class SellYourCarMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form )
    subject    'Reeds  - Sell your car client request'
    recipients ['joergd@pobox.com' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form
  end

end
