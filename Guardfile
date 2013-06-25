guard :rspec, :all_after_pass => true, :all_on_start => true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/high_roller/(.*?)\.rb}) { |m| %Q<spec/unit/#{m[1]}_spec.rb> }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/support/.+.rb}) { "spec" }
end
