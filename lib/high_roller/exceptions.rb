module HighRoller::Exceptions
  class Base < StandardError; end
  class BadServerResponse < Base; end
  class BadSubclass < Base; end
  class ParseError < Base; end
  class QuotaExceeded < Base; end
  class UnknownStrategy < Base; end
  class WrongStrategy < Base; end
end
