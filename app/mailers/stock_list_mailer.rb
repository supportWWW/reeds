class StockListMailer < ActionMailer::Base
  
  helper :application
  
  def list(name, email, stocklist)
    subject    'Reeds  - Stock List'
    recipients ["#{name} <#{email}>" ]
    from        "Reeds <direct@reeds.co.za>"
    sent_on    Time.now
    body       :name => name, :email => email, :stocklist => stocklist
  end

end
