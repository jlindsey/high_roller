# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'high_roller/version'

Gem::Specification.new do |spec|
  spec.name          = "high_roller"
  spec.version       = HighRoller::VERSION
  spec.authors       = ["Josh Lindsey"]
  spec.email         = ["josh@core-apps.com"]
  spec.description   = "Simple plain-text dice roller"
  spec.summary       = "Roll dice using familliar syntax with true randomness from random.org."
  spec.homepage      = "https://github.com/jlindsey/high_roller"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "guard", "~> 1.8.1"
  spec.add_development_dependency "guard-rspec", "~> 3.0.2"
  spec.add_development_dependency "pry"

  spec.add_dependency "treetop", "1.4.14"
end
