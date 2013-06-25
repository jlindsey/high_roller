module HighRoller::Parsing::Dice
  def roll rands
    results = {}

    self.rolls.each do |r|
      puts r.radix
      label = r.text_value.sub /,?\s*$/, ''
      results[label] = r.result(rands[r.radix])
    end

    results
  end

  def rolls
    self.roll_captures.elements
  end
end
