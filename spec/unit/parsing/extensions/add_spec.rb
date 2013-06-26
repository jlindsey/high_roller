require 'spec_helper'

describe HighRoller::Parsing::Add do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class
  end

  it 'adds two numbers' do
    @mixin.should respond_to(:apply)
    @mixin.apply(1, 2).should == 3
    @mixin.apply(5, 5).should == 10
    @mixin.apply(5, -5).should == 0
  end
end
