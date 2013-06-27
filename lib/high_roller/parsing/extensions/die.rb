module HighRoller::Parsing::Die
  def roll rands
    rolls = []
    self.count.to_i.times { rolls << rands.get(self.radix.to_i) }

    rolls
  end
end
