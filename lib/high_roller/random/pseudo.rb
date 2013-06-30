class HighRoller::Random::Pseudo < HighRoller::Random::Base
  def fetch rads = nil
    radixes = rads || @radixes
    out = {}

    radixes.each do |rad|
      ary = []

      @preload.times do
        ary << rand(1..rad)
      end

      out[rad] = ary
    end

    out
  end
end
