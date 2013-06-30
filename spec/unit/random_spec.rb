require 'spec_helper'

describe HighRoller::Random do
  Classes = [:Base, :Api, :Pseudo, :Generator]

  it "autoloads its classes" do
    HighRoller::Random.constants.sort.should == Classes.sort

    Classes.each do |c|
      expect { HighRoller::Random.const_get(c) }.to_not raise_error
    end
  end
end
