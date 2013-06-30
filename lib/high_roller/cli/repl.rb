require 'pp'
require 'readline'

class HighRoller::CLI::REPL
  QuitStrings = %w(!!! quit exit)
  QuotaStrings = %w(quota q)

  def initialize strategy = :api
    @rgen = HighRoller::Random::Generator.new strategy
    @parser = HighRoller::Parsing::Parser.instance
  end

  def run!
    while true
      input = Readline::readline('> ').strip
      Readline::HISTORY.push input

      case check_specials(input)
      when :quit then break
      when :next then next
      end

      begin
        dice = @parser.parse input
      rescue HighRoller::Exceptions::ParseError => e
        puts "Unable to parse input: #{e.message}"
        next
      end

      pp dice.roll(@rgen)
    end
  end

  def check_specials input
    if QuitStrings.include? input
      puts "Quitting"
      return :quit
    elsif QuotaStrings.include? input
      begin
        quota = HighRoller::CLI.humanize_number @rgen.quota
        puts "Currently remaining quota: #{quota}"
      rescue => e
        puts e.message
      end

      return :next
    end

    return false
  end
end
