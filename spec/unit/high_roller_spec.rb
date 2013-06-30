require 'spec_helper'

describe HighRoller do
  Modules = [:VERSION, :CLI, :Random, :Parsing, :Exceptions]

  it "autoloads the correct modules" do
    HighRoller.constants.sort.should == Modules.sort

    Modules.each do |mod|
      expect { HighRoller.const_get(mod) }.to_not raise_error
    end
  end

  it "exposes the gem version" do
    HighRoller::VERSION.should be_a(String)
    HighRoller::VERSION.should =~ /[0-9]+\.[0-9]+\.[0-9]+/
  end
end
