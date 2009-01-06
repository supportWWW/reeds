class BookTestDriveMailer < ActionMailer::Base
  
  helper :application
  
  def neww( frm )
    subject    'Reeds  - Book Test Drive'
    recipients ['rv@imaginet.co.za', 'direct@reeds.co.za']
    from        "i-am-robot-dont-respond@reeds.co.za"
    sent_on    Time.now
    body       :form => frm
  end

end
