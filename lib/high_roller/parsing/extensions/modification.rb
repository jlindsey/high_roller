module HighRoller::Parsing::Modification
  def apply val
    self.operation.apply val, self.number.to_i
  end
end
