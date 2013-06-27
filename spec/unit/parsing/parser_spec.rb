require 'spec_helper'

describe HighRoller::Parsing::Parser do
  before(:each) do
    HighRoller::Parsing::Parser.instance_variable_set(:@__instance, nil)
  end

  it { should have_constant(:GrammarFilePath) }
  it { should respond_to(:grammar) }

  it "is a pseudo-singleton" do
    described_class.any_instance.should_receive(:reload!).once
    described_class.instance.should == described_class.instance
  end

  it "calls #reload! on initialization" do
    described_class.any_instance.should_receive(:reload!).once
    described_class.new
  end

  describe '#reload!' do
    it "loads and instantiates the Treetop grammar parser" do
      Treetop.should_receive(:load).with(HighRoller::Parsing::Parser::GrammarFilePath).and_return(Object)
      
      parser = HighRoller::Parsing::Parser.new
      parser.grammar.should be_a(Object)
    end
  end

  describe '#parse!' do
    before(:each) do
      @parser = described_class.new
    end

    it "passes the input to the treetop parser and returns its output" do
      @parser.grammar.should_receive(:parse).with('1d20').and_return(true)
      @parser.parse('1d20').should == true
    end

    it "raises an exception on parsing failure" do
      expect { @parser.parse('abc123') }.to raise_error(HighRoller::Exceptions::ParseError)
    end
  end
end
