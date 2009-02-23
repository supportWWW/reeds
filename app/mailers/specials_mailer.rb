class SpecialsMailer < ActionMailer::Base
  
  helper :application
  
  def client_request( form, referrals = [] )
    subject    'Reeds  - Specials Request'
    recipients ['direct@reeds.co.za' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form, :referrals => referrals
  end

end
