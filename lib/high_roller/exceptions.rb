module HighRoller::Exceptions
  autoload :QuotaExceeded,     'high_roller/exceptions/quota_exceeded'
  autoload :BadServerResponse, 'high_roller/exceptions/bad_server_response'
  autoload :ParseError,        'high_roller/exceptions/parse_error'
end
