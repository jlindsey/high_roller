class HighRoller::CLI::Single
  def parse input
    rgen = HighRoller::Random::Generator.new :pseudo
    parser = HighRoller::Parsing::Parser.instance
    
    begin
      dice = parser.parse(input.strip)
    rescue HighRoller::Exceptions::ParseError => e
      puts "Unable to parse input: #{e.message}"
      exit 1
    end

    dice.roll(rgen)
  end
end
