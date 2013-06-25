module HighRoller::Parsing
  autoload :Parser, 'high_roller/parsing/parser'

  autoload :Dice,         'high_roller/parsing/extensions/dice'
  autoload :Die,          'high_roller/parsing/extensions/die'
  autoload :Roll,         'high_roller/parsing/extensions/roll'
  autoload :Number,       'high_roller/parsing/extensions/number'
  autoload :Modification, 'high_roller/parsing/extensions/modification'
  autoload :Add,          'high_roller/parsing/extensions/add'
  autoload :Subtract,     'high_roller/parsing/extensions/subtract'
end
