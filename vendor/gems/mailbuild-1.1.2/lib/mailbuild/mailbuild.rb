require 'soap/wsdlDriver'
require 'cgi'
require 'support/cattr_accessor'
require 'mailbuild/mailbuild_error'

# Implementation of the Mailbuild API.

class Mailbuild
  
  include MailbuildError
  
  cattr_accessor :api_key, :default_list_id, :list_ids, :subdomain
  
  # Implements Subscriber.Add
  # http://www.mailbuild.com/api/subscriber.add.aspx
  #
  def self.add(email, name, list_id = nil)
    self.connect
    list_id ||= @@default_list_id    
    result = @@service.AddSubscriber({:ApiKey=>@@api_key, :ListID=>list_id, :Email=>email, :Name=>name})
    response = result.subscriber_AddResult
    self.parse_response(response, 'Subscriber.Add')
  end
  
  # Implements Subscriber.AddWithCustomFields
  # http://www.mailbuild.com/api/subscriber.addwithcustomfields.aspx
  #
  def self.add_with_custom_field(email, name, custom_fields = {}, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    
    # Convert custom fields to an array of hashes
    custom = custom_fields.collect{|key, value| {:Key => key.to_s, :Value => value}}    

    result = @@service.AddSubscriberWithCustomFields({:ApiKey=>@@api_key, :ListID=>list_id, :Email=>email, :Name=>name, :CustomFields=>{:SubscriberCustomField =>custom}})
    response = result.subscriber_AddWithCustomFieldsResult
    self.parse_response(response, 'Subscriber.AddWithCustomFields')
  end

  # Implements <tt>Subscriber.Unsubscribe</tt>
  # http://www.mailbuild.com/api/subscriber.unsubscribe.aspx
  #
  def self.unsubscribe(email, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    result = @@service.Unsubscribe({:ApiKey=>@@api_key, :ListID=>list_id, :Email=>email})
    response = result.subscriber_UnsubscribeResult
    self.parse_response(response, 'Subscriber.Unsubscribe')
  end
  
  # This method is undocumented.
  #
  # Implements Subscribers.GetSingleSubscriber
  #
  def self.subscriber(email, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    result = @@service.GetSingleSubscriber({:ApiKey=>@@api_key, :ListID=>list_id, :EmailAddress=>email})
    subscriber = result.subscribers_GetSingleSubscriberResult    
    self.parse_response(subscriber, 'Subscribers.GetSingleSubscriber')
  end

  # The Mailbuild API documentation is currently out of date.
  # This method is actually implemented as Subscribers.GetSubscribers
  #
  # Implements Subscribers.GetActive
  # http://www.mailbuild.com/api/Subscribers.GetActive.aspx
  #
  def self.subscribers(date, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    result = @@service.GetSubscribers({:ApiKey=>@@api_key, :ListID=>list_id, :Date=>date})
    subscribers = result.subscribers_GetActiveResult
    self.parse_response(subscribers, 'Subscribers.GetSubscribers')
  end

  # Implements Subscribers.GetUnsubscribed
  # http://www.mailbuild.com/api/Subscribers.GetUnsubscribed.aspx
  #
  def self.unsubscribed(date, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    result = @@service.GetUnsubscribed({:ApiKey=>@@api_key, :ListID=>list_id, :Date=>date})
    unsubscribed = result.subscribers_GetUnsubscribedResult
    self.parse_response(unsubscribed, 'Subscribers.GetUnsubscribed')
  end

  # Implements Subscribers.GetBounced
  # http://www.mailbuild.com/api/Subscribers.GetBounced.aspx
  #
  def self.bounced(date, list_id = nil)
    self.connect
    list_id ||= @@default_list_id
    result = @@service.GetBounced({:ApiKey=>@@api_key, :ListID=>list_id, :Date=>date})
    bounced = result.subscribers_GetBouncedResult
    self.parse_response(bounced, 'Subscribers.GetBounced')
  end
  
  protected
  
    def self.connect
      self.check_config
      # Set the default list id
      @@default_list_id = @@list_ids.values.first
      wsdl_url = "http://#{@@subdomain}.createsend.com/api/api.asmx?wsdl"
      @@service = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver or raise ConnectionError.new('Unable to self.connect to Mailbuild SOAP service. Network problem?')
      @@service.wiredump_dev = STDERR if $DEBUG
    end
    
    def self.check_config
      raise ArgumentError.new("Please set your Mailbuild API key") if @@api_key.blank?
      raise ArgumentError.new("Please set your Mailbuild list IDs") if @@list_ids.blank?
      raise ArgumentError.new("Please set your Mailbuild subdomain") if @@subdomain.blank?
    end
  
    def self.parse_response(response, method_name)
      if response.respond_to? :code
        response_code = response.code.to_i
        self.parse_response_code(response_code, method_name)
      else
        self.handle_subscribers_list(response, method_name)
      end
    end
  
    def self.parse_response_code(response_code, method_name)
      case response_code
        when 1
          raise EmailError.new("#{method_name}: Invalid email address.")
        when 5
          raise DateError.new("#{method_name}: Invalid date.")
        when 100
          raise APIKeyError.new("#{method_name}: Invalid API Key.")
        when 101
          raise ListIDError.new("#{method_name}: Invalid ListID.")
        when 203
          raise SubscriberNotFoundError.new("#{method_name} Subscriber not in list.")
        else
          return true
      end
    end
    
    def self.handle_subscribers_list(subscribers, method_name)
      if subscribers.respond_to?(:subscriber)
        if subscribers.subscriber.is_a? Array
          subscribers.subscriber.collect{|subscriber| self.create_subscriber_object(subscriber)}
        else
          [self.create_subscriber_object(subscribers.subscriber)]
        end
      elsif subscribers.respond_to?(:emailAddress)
        self.create_subscriber_object(subscribers)
      else
        raise SubscribersNotFoundError.new("#{method_name}: No subscribers returned.")
      end
    end
    
    def self.create_subscriber_object(subscriber)
      custom = self.parse_custom_fields(subscriber)
      {:email => subscriber.emailAddress, :name => subscriber.name, :subscribed_at => subscriber.date, :state => subscriber.state, :custom => custom}
    end
      
    def self.parse_custom_fields(subscriber)
      if subscriber.respond_to?(:customFields) && subscriber.customFields.respond_to?(:subscriberCustomField)
        debugger
        test_val = (subscriber.customFields.subscriberCustomField.is_a?(Array)) ? subscriber.customFields.subscriberCustomField.first : subscriber.customFields.subscriberCustomField
        unless test_val.value.is_a?(SOAP::Mapping::Object)
          return subscriber.customFields.subscriberCustomField.to_a
        end
      end
      return nil
    end
      
end