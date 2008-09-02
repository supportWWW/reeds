class StockList
  def self.send
    Mailbuild.list_id = MAILBUILD_STOCK_LIST_ID
    subscribers = Mailbuild.subscribers("2008-01-01 00:00:00")

    stocklist = stock
    subscribers.each do |subscriber|
      StockListMailer.deliver_list(subscriber[:name], subscriber[:email], stocklist)
    end
    
    rescue MailbuildError::SubscribersNotFoundError
      @message = 'No subscribers were found for this list.'
    rescue MailbuildError::DateError
      @message = 'Invalid date.'
    rescue MailbuildError::ListIDError
      @message = 'Invalid API Key.'
    rescue MailbuildError::APIKeyError
      @message = 'Invalid ListID.'
    rescue HTTPAccess2::Session::KeepAliveDisconnected
      @message = 'Mailbuild Timeout'
      
  end
  
  def self.stock
    list = []
    Classified.available.find(:all, :order => "makes.common_name, models.common_name, price_in_cents").each do |classified|
      list << "#{classified.humanize} #{classified.year} (#{classified.mileage}km): #{classified.price.format(:no_cents)}"
    end
    return list
  end
end