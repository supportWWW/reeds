class SpecialsMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form )
    subject    'Reeds  - Specials Request'
    recipients ['joergd@pobox.com', 'direct@reeds.co.za' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form
  end

end
