require 'spec_helper'

describe HighRoller::Exceptions do
  Subclasses = [:Base, :BadServerResponse, :BadSubclass, :ParseError, :QuotaExceeded, :UnknownStrategy, :WrongStrategy]

  it 'defines the correct classes' do
    HighRoller::Exceptions.constants.sort.should == Subclasses.sort
  end

  Subclasses.each do |ex|
    describe "#{ex}" do
      before(:each) do
        @ex = HighRoller::Exceptions.const_get(ex).new
      end

      it 'is a subclass of Base' do
        @ex.should be_a(HighRoller::Exceptions::Base)
      end

      it 'is a StandardError' do
        @ex.should be_a(StandardError)
      end
    end
  end
end
