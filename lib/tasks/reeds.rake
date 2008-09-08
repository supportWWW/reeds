namespace :reeds do
  
  namespace :stocklist do
    desc "Send stocklists"
    task :send do
      load 'config/environment.rb'
      StockList.send
    end
  end
  
  namespace :cyberstock do
    desc "Send soon-to-expire cyberstock"
    task :send_expire do
      load 'config/environment.rb'
      Cyberstock.expiry_check
    end
  end
  
end