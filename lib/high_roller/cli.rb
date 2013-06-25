module HighRoller::CLI
  autoload :REPL,   'high_roller/cli/repl'
  autoload :Single, 'high_roller/cli/single'

  def self.humanize_number num
    raise "Not a number: #{num}" if num.to_s =~ /[^\d]/
    num.to_s.reverse.scan(/\d{1,3}/).join(',').reverse
  end
end
