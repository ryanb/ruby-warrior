When /^I copy fixture "([^\"]*)" to "([^\"]*)"$/ do |from, to|
  File.copy("features/fixtures/" + from, to)
end

Then /^I should find file at "([^\"]*)"$/ do |path|
  File.exist?(path).should be_true
end
