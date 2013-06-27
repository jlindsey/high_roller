class RandomGenImposter
  attr :data

  def initialize hash
    @data = hash
  end

  def get key
    @data[key].pop
  end
end
