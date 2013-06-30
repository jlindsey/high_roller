class HighRoller::Random::Base
  attr_reader :preload, :radixes

  def initialize opts
    @preload = opts[:preload]
    @radixes = opts[:radixes]
  end

  def fetch rads = nil
    raise HighRoller::Exceptions::BadSubclass.new('Subclasses of HighRoller::Random::Base must override #fetch')
  end
end
