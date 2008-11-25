class CallbackMailer < ActionMailer::Base
  
  helper :application
  
  def requested(form, salespeople)
    subject    'Reeds  - Callback requested SMS sent'
    recipients ['joergd@pobox.com' ]
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => form, :salespeople => salespeople
  end

end
