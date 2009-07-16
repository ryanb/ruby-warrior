Given /^a profile named "([^\"]*)"$/ do |name|
  When 'I run rubywarrior'
  And 'I answer "y" to "create one?"'
  And 'I answer "1" to "tower"'
  And 'I answer "' + name + '" to "name"'
  Then 'I should see "generated"'
  And 'I should find file at "ruby-warrior"'
end

Given /^I have no profile$/ do
  RubyWarrior::Config.path_prefix = "tmp"
  FileUtils.rm_rf("tmp/ruby-warrior")
end

When /^I run rubywarrior$/ do
  @io = MockIO.new
  @io.start do |io|
    RubyWarrior::UI.out_stream = io
    RubyWarrior::UI.in_stream = io
    RubyWarrior::Game.new.start
  end
end

When /^I answer "([^\"]*)" to "([^\"]*)"$/ do |answer, question|
  @io.gets_until_include(question)
  @io.puts(answer)
end

When /^I choose "([^\"]*)" for "([^\"]*)"$/ do |choice, phrase|
  answer = nil
  content = @io.gets_until_include(phrase)
  content.split("\n").each do |line|
    if line.include?(choice) && line =~ /\[(\d)\]/
      answer = $1
    end
  end
  if answer
    @io.puts(answer)
  else
    raise "Unable to find choice #{choice} in #{content}"
  end
end

When /^I wait until it says "([^\"]*)"$/ do |phrase|
  @io.gets_until_include(phrase)
end

Then /^I should see "([^\"]*)"$/ do |phrase|
  @io.gets_until_include(phrase).should include(phrase)
end

Then /^I should find file at "([^\"]*)"$/ do |path|
  File.exist?("tmp/" + path).should be_true
end
