RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    o = (owner.class != Class) ? owner.class : owner
    o.const_defined?(const)
  end
end
