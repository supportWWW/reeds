class CallbackMailer < ActionMailer::Base
  
  helper :application
  
  def requested(form, salespeople, referrals)
    subject    'Reeds  - Callback requested SMS sent'
    recipients ['rv@imaginet.co.za', 'direct@reeds.co.za' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form, :salespeople => salespeople, :referrals => referrals
  end

end
