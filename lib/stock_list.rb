class StockList
  def self.send
    stocklist = stock

    #Mailbuild.default_list_id = MAILBUILD_STOCK_LIST_ID
    subscribers = Mailbuild.subscribers("2008-01-01 00:00:00", MAILBUILD_STOCK_LIST_ID )

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

  def self.send_weekly
    stocklist = stock

    #Mailbuild.default_list_id = MAILBUILD_STOCK_LIST_ID
    subscribers = Mailbuild.subscribers("2008-01-01 00:00:00", MAILBUILD_WEEKLY_STOCK_LIST_ID )

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
#    rescue HTTPAccess2::Session::KeepAliveDisconnected
#      @message = 'Mailbuild Timeout'

  end
  
  def self.stock
    Classified.available.find(:all, :order => "makes.common_name, models.common_name, price_in_cents") # .each do |classified|
    #list = []
#    @list =  Classified.available.find(:all, :order => "makes.common_name, models.common_name, price_in_cents") # .each do |classified|
#    puts @list.to_yaml
    #  list << classified # "#{classified.humanize} #{classified.year} (#{classified.mileage}km): #{classified.price.format}"
    #end
    #return list
#    @list_final = []
#    @list.each do |row|
#      if !row[:permalink].nil?
##        @url = "http://www.reeds.co.za/classifieds/" << row[:permalink]
##        row[:url] = @url
#        @list_final = row
#        puts @list_final.inspect
#      else
#        puts "no permalink"
#      end
#      raise @list_final.inspect
#    end
  end
end