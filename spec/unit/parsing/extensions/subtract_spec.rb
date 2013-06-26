require 'spec_helper'

describe HighRoller::Parsing::Subtract do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class
  end

  it 'subtracts two numbers' do
    @mixin.should respond_to(:apply)
    @mixin.apply(2, 1).should == 1
    @mixin.apply(5, 5).should == 0
    @mixin.apply(10, 5).should == 5
  end
end
