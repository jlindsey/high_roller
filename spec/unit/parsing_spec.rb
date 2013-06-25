require 'spec_helper'

describe HighRoller::Parsing do
  it "autoloads its classes" do
    expect { HighRoller::Parsing::Parser }.to_not raise_error

    expect { HighRoller::Parsing::Dice }.to_not raise_error
    expect { HighRoller::Parsing::Die }.to_not raise_error
    expect { HighRoller::Parsing::Roll }.to_not raise_error
    expect { HighRoller::Parsing::Number }.to_not raise_error
    expect { HighRoller::Parsing::Modification }.to_not raise_error
    expect { HighRoller::Parsing::Add }.to_not raise_error
    expect { HighRoller::Parsing::Subtract }.to_not raise_error
  end
end
