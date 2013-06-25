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
      @sio = StringIO.new
      @old_out = $stdout
      $stdout = @sio

      @parser = described_class.new
    end

    after(:each) do
      $stdout = @old_out
    end

    it "passes the input to the treetop parser and returns its output" do
      @parser.grammar.should_receive(:parse).with('1d20').and_return(true)
      @parser.parse('1d20').should == true
    end

    it "prints the failure reason" do
      @parser.parse('abc123')
      @sio.string.should == "Unable to parse input\n"
    end
  end
end
