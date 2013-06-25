require 'spec_helper'

describe HighRoller::CLI do
  it 'autoloads its classes' do
    expect { HighRoller::CLI::REPL }.to_not raise_error
    expect { HighRoller::CLI::Single }.to_not raise_error
  end

  describe "#humanize_number" do
    it "prints a number separated by commas" do
      HighRoller::CLI.should respond_to(:humanize_number)

      HighRoller::CLI.humanize_number(1_234_567_890).should == '1,234,567,890'
      HighRoller::CLI.humanize_number('8135610').should == '8,135,610'
    end

    it "raises an exception when passed a non-numeral" do
      expect { HighRoller::CLI.humanize_number('123abc') }.to raise_error('Not a number: 123abc')
      expect { HighRoller::CLI.humanize_number(rand(10_000)) }.to_not raise_error
      expect { HighRoller::CLI.humanize_number('1234567890') }.to_not raise_error
    end
  end
end
