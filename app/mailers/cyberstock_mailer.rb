class CyberstockMailer < ActionMailer::Base
  
  helper :application
  
  def soon_to_expire(tos, cyberstocks)
    subject    'Reeds  - Cyberstock Soon to Expire'
    recipients [*tos ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :cyberstocks => cyberstocks
  end

end
