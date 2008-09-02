class StockList
  def self.send
    stocklist = stock

    Mailbuild.list_id = MAILBUILD_STOCK_LIST_ID
    subscribers = Mailbuild.subscribers("2008-01-01 00:00:00")

    subscribers.each do |subscriber|
      StockListMailer.deliver_list(subscriber[:name], subscriber[:email], stocklist)
      puts "Stocklist delivered to #{subscriber[:email]}"
    end
    
    rescue MailbuildError::SubscribersNotFoundError
      puts 'No subscribers were found for this list.'
    rescue MailbuildError::DateError
      puts 'Invalid date.'
    rescue MailbuildError::ListIDError
      puts 'Invalid API Key.'
    rescue MailbuildError::APIKeyError
      puts 'Invalid ListID.'
    #rescue HTTPAccess2::Session::KeepAliveDisconnected
    #  @message = 'Mailbuild Timeout'
      
  end
  
  def self.stock
    list = []
    Classified.available.find(:all, :order => "makes.common_name, models.common_name, price_in_cents").each do |classified|
      list << "#{classified.humanize} #{classified.year} (#{classified.mileage}km): #{classified.price.format(:no_cents)}"
    end
    return list
  end
end