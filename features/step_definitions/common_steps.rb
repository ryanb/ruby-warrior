When /^I copy fixture "([^\"]*)" to "([^\"]*)"$/ do |from, to|
  FileUtils.cp_r("spec/fixtures/" + from, to)
end

Then /^I should find file at "([^\"]*)"$/ do |path|
  File.exist?(path).should be_true
end
