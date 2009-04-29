require 'net/http'
require 'open-uri'
require 'cgi'
require 'uuidtools'

class HugeSms

	@@huge_url = 'http://smsza.telepassport.co.za:80/SMS/SMSSend.jsp'
  @@application_id = "62"

  def self.deliver(number, message, username = '32888452', password = 'Reeds01')
    puts "Connecting to HugeSms..."
    ActiveRecord::Base.logger.info "Connecting to HugeSms..."
    Net::HTTP.start('smsza.telepassport.co.za') do |http|
    #Net::HTTP.start('reeds.webhop.net') do |http|
      puts "Connected."
      ActiveRecord::Base.logger.info "Connected."
      xml = create_xml(number, message, username, password).to_xs
      xml.gsub!("<to_xs/>", "") # WHY ????????????????????????????
      puts xml
      ActiveRecord::Base.logger.info xml
      return_xml = http.post("/SMS/SMSSend.jsp", "xmldata=#{xml}").body
      return_xml.include?("OK")
    end
  end

  def self.create_xml(number, message, username, password)
    x = Builder::XmlMarkup.new(:indent => 2)
    x.instruct! :xml, :version=>"1.0"
    x.XML {
      x.SENDBATCH(:user => username, :password => password, :application => @@application_id, :reply => "EMAIL:joergd@pobox.com") {
        x.SMSLIST {
          x.SMS_SEND(message, :to => number, :uid => UUID.timestamp_create.to_s)
        }
      }
    }
    return x
  end
  
end
