require 'spec_helper'

describe HighRoller::Parsing::Number do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class
  end

  it 'calls #to_i on #text_value' do
    @mixin.should respond_to(:to_i)
    @mixin.should_receive(:text_value).and_return('14')

    @mixin.to_i.should == 14
  end
end
