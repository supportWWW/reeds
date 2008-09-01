require 'net/http'
require 'open-uri'
require 'cgi'
require 'uuidtools'

class HugeSms

	@@huge_url = 'http://smsza.telepassport.co.za:80/SMS/SMSSend.jsp'
  @@application_id = "61"

  def self.deliver(number, message, username = 'ivor', password = 'sdcxpw3')
    Net::HTTP.start('smsza.telepassport.co.za') do |http|
      http.post("/SMS/SMSSend.jsp", "xmldata=#{create_xml(number, message, username, password)}").body
    end
  end

  def self.create_xml(number, message, username, password)
    x = Builder::XmlMarkup.new
    x.instruct! :xml, :version=>"1.0"
    x.XML {
      x.SENDBATCH(:user => username, :password => password, :application => @@application_id) {
        x.SMSLIST {
          x.SMS_SEND(message, :to => number, :uid => UUID.timestamp_create.to_s)
        }
      }
    }
  end
  
end
