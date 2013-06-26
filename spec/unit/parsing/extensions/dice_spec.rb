require 'spec_helper'

describe HighRoller::Parsing::Dice do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class

    @roll = double('roll', { :text_value => '1d20,', :radix => 20, :result => { :dice => [14], :modifier => '', :final => 14 } })
    @roll_captures = double('rolls', { :elements => [@roll] })

    @mixin.stub(:roll_captures).and_return(@roll_captures)
  end

  it 'allows access to its captured roll objects' do
    @roll_captures.should_receive(:elements).once
    @mixin.rolls.should == [@roll]
  end

  it 'returns a hash of all roll results' do
    @roll.should_receive(:result).with([1, 2, 3])
    @mixin.roll({ 20 => [1, 2, 3] }).should == { '1d20' => { :dice => [14], :modifier => '', :final => 14 } }
  end
end
