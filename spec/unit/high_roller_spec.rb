require 'spec_helper'

describe HighRoller do
  it "autoloads the correct modules" do
    expect { HighRoller::VERSION }.to_not raise_error
    expect { HighRoller::CLI }.to_not raise_error
    expect { HighRoller::Random }.to_not raise_error
    expect { HighRoller::Parser }.to_not raise_error
  end

  it "exposes the gem version" do
    HighRoller.constants.should include(:VERSION)
    HighRoller::VERSION.should be_a(String)
    HighRoller::VERSION.should =~ /[0-9]+\.[0-9]+\.[0-9]+/
  end
end
