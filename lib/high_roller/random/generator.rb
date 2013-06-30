class HighRoller::Random::Generator
  PreloadAmount = 50
  PreloadRadixes = [6, 8, 10, 20]

  attr_reader :strategy, :delegate, :randoms, :options

  def initialize strategy, opts = {}
    @strategy = strategy
    @randoms = {}

    default_opts = {
      preload: PreloadAmount, 
      radixes: PreloadRadixes
    }
    @options = default_opts.merge opts

    @delegate = get_delegate_for_strategy strategy

    reload!
  end

  def get radix
    rad = radix.to_i
    reload!([rad]) if @randoms[rad].nil? or @randoms[rad].empty?
    @randoms[rad].pop
  end

  def quota
    if @strategy != :api
      raise HighRoller::Exceptions::WrongStrategy.new("Quota only available for Random.org API")
    else
      @delegate.quota
    end
  end

  def reload! radixes = nil
    rands = @delegate.fetch(radixes)
    rands.each do |rad, nums|
      if @randoms[rad].nil?
        @randoms[rad] = nums
      else
        @randoms[rad] += nums
      end
    end
  end

  def get_delegate_for_strategy strategy
    case strategy
    when :api
      return HighRoller::Random::Api.new @options
    when :pseudo
      return HighRoller::Random::Pseudo.new @options
    else
      raise HighRoller::Exceptions::UnknownStrategy.new
    end
  end
end
