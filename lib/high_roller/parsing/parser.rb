require 'treetop'

class HighRoller::Parsing::Parser
  GrammarFilePath = File.join(File.expand_path(File.dirname(__FILE__)), 'dice.tt')
  @__instance = nil

  attr_reader :grammar

  def self.instance
    @__instance ||= new
  end

  def initialize
    reload!
  end

  def parse input
    tree = @grammar.parse input
    
    if tree.nil?
      raise HighRoller::Exceptions::ParseError.new(@grammar.failure_reason)
    end

    tree
  end

  def reload!
    klass = Treetop.load GrammarFilePath
    @grammar = klass.new
  end
end

