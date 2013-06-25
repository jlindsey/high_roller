module HighRoller::Parsing::Die
  def roll rands
    rolls = []
    self.count.to_i.times do 
      val = (rands.empty? || rands.nil?) ? rand(1..self.radix.to_i) : rands.pop
      rolls << val
    end

    rolls
  end
end
