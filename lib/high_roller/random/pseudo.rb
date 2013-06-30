class HighRoller::Random::Pseudo < HighRoller::Random::Base
  def fetch rads = nil
    radixes = rads || @radixes
    out = {}

    radixes.each do |rad|
      ary = []

      @preload.times do
        ary << do_rand(1..rad)
      end

      out[rad] = ary
    end

    out
  end

  private

  def do_rand range
    if RUBY_VERSION >= "1.9.3"
      rand(range)
    else
      @rng ||= ::Random.new
      @rng.rand(range)
    end
  end
end
