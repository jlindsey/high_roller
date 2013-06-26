require 'spec_helper'

describe HighRoller::Parsing::Die do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class
  end

  it 'returns a list of random numbers based on its #count and #radix' do
    @mixin.should_receive(:count).once.and_return(5)
    @mixin.should_receive(:radix).exactly(2).times.and_return(20)

    rands = [1, 2, 3]
    rands.should_receive(:pop).exactly(3).times.and_call_original

    result = @mixin.roll(rands)

    result.should be_an_instance_of(Array)
    result.should have(5).items
    result.each { |i| (1..20).should cover(i) }
    result.first(3).should == [3, 2, 1]
    rands.should be_empty
  end
end
