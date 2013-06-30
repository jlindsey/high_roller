require 'spec_helper'

describe HighRoller::Random::Pseudo do
  before(:each) do
    @opts = {
      preload: 10,
      radixes: [5]
    }
    @rand = described_class.new @opts
  end

  it 'is a subclass of Base' do
    @rand.should be_a(HighRoller::Random::Base)
    expect { @rand.fetch }.to_not raise_error
  end

  describe '#fetch' do
    it 'generates an array of random numbers sized to match @preload' do
      result = @rand.fetch nil
      result.values[0].should have(@opts[:preload]).items
    end

    it 'falls back to the radixes in the options when one is not supplied' do
      20.times do
        result = @rand.fetch nil
        result.keys.should == [5]
        (1..5).should cover(*result[5])
      end
    end

    it 'returns a hash of arrays of random numbers keyed on the correct radixes' do
      rads = (0..50).step(5).to_a.tap { |a| a.delete(0) }
      result = @rand.fetch rads
      result.keys.should == rads

      rads.each do |rad|
        (1..rad).should cover(*result[rad])
      end
    end
  end
end
