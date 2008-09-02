class StockListMailer < ActionMailer::Base
  
  helper :application
  
  def list(name, email, stocklist)
    subject    'Reeds  - Stock List'
    recipients ['joergd@pobox.com', "#{name} <#{email}>" ]
    from        ActionMailer::Base.smtp_settings[:user_name]
    sent_on    Time.now
    body       :name => name, :stocklist => stocklist
  end

end
