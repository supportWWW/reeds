class BookTestDriveMailer < ActionMailer::Base
  
  helper :application
  
  def neww( frm, referrals = [] )
    subject    'Reeds  - Book Test Drive'
    recipients ['direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm, :referrals => referrals
  end

end
