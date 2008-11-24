class FindCarMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form )
    subject    'Reeds  - Find car request'
    recipients ['joergd@pobox.com' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form
  end

end
