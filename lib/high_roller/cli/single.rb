class HighRoller::CLI::Single
  def self.parse argv
    rgen = HighRoller::Random::Generator.new :pseudo

    parser = HighRoller::Parsing::Parser.instance
    
    begin
      dice = parser.parse(argv[0].strip)
    rescue HighRoller::Exceptions::ParseError => e
      puts "Unable to parse input: #{e.message}"
      exit 1
    end

    dice.roll(rgen)
  end
end
