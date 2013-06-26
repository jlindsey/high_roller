require 'spec_helper'

describe HighRoller::Parsing::Modification do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class
  end

  it 'calls #apply on its #operation' do
    op = double('operation')
    op.should_receive(:apply).with(5, 10).and_return(15)

    num = double('number')
    num.should_receive(:to_i).and_return(10)

    @mixin.should_receive(:operation).and_return(op)
    @mixin.should_receive(:number).and_return(num)

    @mixin.apply(5).should == 15
  end
end
