module MailbuildError
  class Error < RuntimeError; end
  class ConnectionError < Error; end
  class EmailError < ArgumentError; end
  class APIKeyError < ArgumentError; end
  class ListIDError < ArgumentError; end
  class SubscribersNotFoundError < RuntimeError; end
  class SubscriberNotFoundError < RuntimeError; end
  class DateError < RuntimeError; end
end