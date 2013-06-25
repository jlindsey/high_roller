module HighRoller::Parsing::Roll
  def result rands
    get_rolls rands
    final = apply_modification(sum(@die_rolls))

    { dice: @die_rolls, mod: modification.text_value, final: final }
  end

  def count
    self.die.count.to_i
  end

  def radix
    self.die.radix.to_i
  end

  def get_rolls rands
    @die_rolls ||= self.die.roll(rands)
  end

  def apply_modification val
    return val unless has_modification?
    self.modification.apply(val)
  end

  def sum rolls
    rolls.reduce(0) { |i, roll| i += roll }
  end

  def has_modification?
    !self.modification.empty?
  end
end
