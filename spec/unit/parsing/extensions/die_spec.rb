require 'spec_helper'

describe HighRoller::Parsing::Die do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class

    @rands = RandomGenImposter.new({ 20 => [1, 2, 3, 4, 5] })
  end

  it 'returns a list of random numbers based on its #count and #radix' do
    @mixin.should_receive(:count).once.and_return(5)
    @mixin.should_receive(:radix).exactly(5).times.and_return(20)

    @rands.should_receive(:get).exactly(5).times.and_call_original

    result = @mixin.roll(@rands)

    result.should be_an_instance_of(Array)
    result.should have(5).items
    result.each { |i| (1..20).should cover(i) }
    result.should == [5, 4, 3, 2, 1]
    @rands.data[20].should be_empty
  end
end
