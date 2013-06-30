require 'spec_helper'

describe HighRoller::Random::Base do
  before(:each) do
    @opts = {
      preload: 10,
      radixes: [6, 8, 20]
    }
  end

  it 'defines read-only methods for its internal vars' do
    methods = [:preload, :radixes]
    @base = described_class.new @opts

    methods.each do |method|
      @base.should respond_to(method)
      @base.should_not respond_to(method.to_s.tap { |s| s << '=' }.to_sym)
    end
  end

  it 'requires an options hash on init' do
    expect { described_class.new }.to raise_error
  end

  it 'assigns the options hash to its internal vars' do
    @base = described_class.new @opts
    @base.preload.should == @opts[:preload]
    @base.radixes.should == @opts[:radixes]
  end

  it 'raises an exception if its version of #fetch is called directly' do
    @base = described_class.new @opts
    expect { @base.fetch }.to raise_error(HighRoller::Exceptions::BadSubclass,
                                          'Subclasses of HighRoller::Random::Base must override #fetch')
  end
end

