class CyberstockMailer < ActionMailer::Base
  
  helper :application
  
  def soon_to_expire(tos, cyberstock)
    subject    'Reeds  - Cyberstock Soon to Expire'
    recipients ['joergd@pobox.com', *tos ]
    from        ActionMailer::Base.smtp_settings[:user_name]
    sent_on    Time.now
    body       :cyberstock => cyberstock
  end

end
