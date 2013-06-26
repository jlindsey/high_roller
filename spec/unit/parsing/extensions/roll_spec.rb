require 'spec_helper'

describe HighRoller::Parsing::Roll do
  before(:each) do
    @mixin = Object.new
    @mixin.extend described_class

    @die = double('die', { :count => 3, :radix => 20, :roll => [1, 2, 3] })
    @modification = double('modification', { :empty? => false, :apply => 12, :text_value => '+12' })
    @mixin.stub(:die).and_return(@die)
    @mixin.stub(:modification).and_return(@modification)
  end

  it 'passes through #count and #radix to the underlying Die object' do
    @die.should_receive(:count)
    @die.should_receive(:radix)

    @mixin.count.should == 3
    @mixin.radix.should == 20
  end

  it 'passes through #rolls to the underlying Die and stores the result' do
    @die.should_receive(:roll).with([1, 2]).exactly(:once)
    @mixin.get_rolls([1, 2]).should == [1, 2, 3]
    @mixin.instance_variable_get(:@die_rolls).should == [1, 2, 3]
    @mixin.get_rolls([1, 2]).should == [1, 2, 3]
  end

  it 'sums arrays of numbers' do
    @mixin.sum([1, 2, 3]).should == 6
    @mixin.sum([50, 50]).should == 100
  end

  it 'determines if it has a valid modification' do
    @modification.should_receive(:empty?)
    @mixin.has_modification?.should == true
  end

  describe '#apply_modification' do
    it 'returns the passed-in value if there is no modification' do
      @mixin.stub(:has_modification?).and_return(false)
      @mixin.apply_modification(12).should == 12
      @mixin.apply_modification(40).should == 40
    end

    it 'passes the value through to the modification #apply method' do
      @modification.should_receive(:apply).with(6).once
      @mixin.apply_modification(6).should == 12
    end
  end

  it 'returns a hash of roll information' do
    @mixin.should_receive(:apply_modification).with(24).and_return(48)
    @mixin.should_receive(:sum).with([12, 12]).and_return(24)
    @mixin.should_receive(:get_rolls).with([12, 12]).and_return([12, 12])
    @mixin.instance_variable_set(:@die_rolls, [12, 12])

    @mixin.result([12, 12]).should == { dice: [12, 12], mod: '+12', final: 48 }
  end
end
