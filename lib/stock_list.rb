class StockList
  def self.send
    Mailbuild.list_id = MAILBUILD_STOCK_LIST_ID
    subscribers = Mailbuild.subscribers("2008-01-01 00:00:00")

    subscribers.each do |subscriber|
      puts(subscriber[:email])
    end
    
    rescue MailbuildError::SubscribersNotFoundError
      @message = 'No subscribers were found for this list.'
    rescue MailbuildError::DateError
      @message = 'Invalid date.'
    rescue MailbuildError::ListIDError
      @message = 'Invalid API Key.'
    rescue MailbuildError::APIKeyError
      @message = 'Invalid ListID.'
  end
  
end