require 'spec_helper'

describe HighRoller::Random do
  it "autoloads its classes" do
    expect { HighRoller::Random::Pseudo }.to_not raise_error
    expect { HighRoller::Random::Api }.to_not raise_error
  end
end
