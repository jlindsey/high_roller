require 'spec_helper'

describe HighRoller::Random::Generator do
  before(:each) do
    @opts = {
      preload: 5,
      radixes: [20]
    }

    @delegate = double('delegate', { :fetch => [1, 2, 3, 4, 5], :quota => 100 })
    described_class.any_instance.stub(:get_delegate_for_strategy).and_return(@delegate)
  end

  it 'sets initial vars on init' do
    described_class.any_instance.should_receive(:reload!).once
    described_class.any_instance.should_receive(:get_delegate_for_strategy).once

    @gen = described_class.new :foo, @opts

    @gen.strategy.should == :foo
    @gen.options.should == @opts
    @gen.delegate.should == @delegate
    @gen.randoms.should == {}
  end

  describe '#quota' do
    it 'raises an error if the delegate does not support quotas' do
      @gen = described_class.new :foo, @opts
      expect { @gen.quota }.to raise_error(HighRoller::Exceptions::WrongStrategy,
        'Quota only available for Random.org API')
    end

    it 'returns the remaining quota as determined by the delegate' do
      @gen = described_class.new :api, @opts
      @delegate.should_receive(:quota).twice
      expect { @gen.quota }.to_not raise_error
      @gen.quota.should == 100
    end
  end
  
  describe '#get' do
    before(:each) do
      @gen = described_class.new :foo, @opts
      @rands = { 20 => [1, 2, 3], 6 => [4, 5, 6] }
      @gen.instance_variable_set(:@randoms, @rands)
    end

    it 'pops a number off the specified array in @randoms' do
      @gen.should_not_receive(:reload!)

      @gen.get(20).should == 3
      @gen.get(6).should == 6

      @rands[20].should == [1, 2]
      @rands[6].should == [4, 5]
    end

    it 'calls #reload! with the correct radix if it runs out of numbers' do
      @gen.should_receive(:reload!).with([20]).and_return(true)
      4.times { @gen.get(20) }
    end

    it 'calls #reload! with the correct radix if it has no numbers for a radix' do
      @gen.should_receive(:reload!).with([3]) { @rands[3] = [10] }
      @gen.get(3).should == 10
    end
  end

  describe '#reload!' do
    before(:each) do
      @gen = described_class.new :foo, @opts
      @randoms = {}
      @delegate = double('delegate')
      @gen.instance_variable_set(:@randoms, @randoms)
      @gen.instance_variable_set(:@delegate, @delegate)
    end

    it 'calls @delegate#fetch with the proper radixes' do
      @delegate.should_receive(:fetch).with([20, 6]).once.and_return({ 20 => [], 6 => [] })
      @gen.reload!([20, 6])

      @delegate.should_receive(:fetch).with(nil).once.and_return({ 20 => [] })
      @gen.reload!
    end

    it 'assigns the fetched array to the correct key in @randoms if it is empty or nil' do
      @delegate.should_receive(:fetch).with([20]).once.and_return({ 20 => [1, 2, 3, 4] })
      @gen.reload!([20])
      @randoms.should have_key(20)
      @randoms[20].should == [1, 2, 3, 4]

      @delegate.should_receive(:fetch).with([20]).once.and_return({ 20 => [7, 8, 9] })
      @randoms[20] = []
      @gen.reload!([20])
      @randoms[20].should == [7, 8, 9]
    end

    it 'merges the fetched array into the correct key in @randoms if it already has elements' do
      @randoms[20] = [1, 2, 3]
      @delegate.should_receive(:fetch).with(nil).once.and_return({ 20 => [4, 5, 6] })
      @gen.reload!
      @randoms[20].should == [1, 2, 3, 4, 5, 6]
    end
  end

  describe '#get_delegate_for_strategy' do
    before(:each) do
      @gen = described_class.new :foo, @opts
      @gen.stub(:get_delegate_for_strategy).and_call_original
    end

    it 'raises an error if there is no defined delegate class for the strategy' do
      expect { @gen.get_delegate_for_strategy(:foo) }.to raise_error(HighRoller::Exceptions::UnknownStrategy)
    end

    it 'instantiates pseudo-random delegates' do
      del = @gen.get_delegate_for_strategy(:pseudo)
      del.should be_an_instance_of(HighRoller::Random::Pseudo)
    end

    it 'instantiates api delegates' do
      HighRoller::Random::Api.any_instance.stub(:refresh_quota!)
      del = @gen.get_delegate_for_strategy(:api)
      del.should be_an_instance_of(HighRoller::Random::Api)
    end
  end
end
