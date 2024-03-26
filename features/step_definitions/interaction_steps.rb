Given /^a profile named "([^\"]*)" on "([^\"]*)"$/ do |name, tower|
  step 'I run rubywarrior'
  step 'I answer "y" to "create one?"'
  step 'I choose "' + tower + '" for "tower"'
  step 'I answer "' + name + '" to "name"'
  step 'I should see "generated"'
end

Given /^no profile at "([^\"]*)"$/ do |path|
  RubyWarrior::Config.path_prefix = path
  FileUtils.rm_rf("#{path}/rubywarrior")
end

Given /^current directory is "([^\"]*)"$/ do |path|
  RubyWarrior::Config.path_prefix = path
end

When /^I run rubywarrior$/ do
  @io = MockIO.new
  @io.start do |io|
    RubyWarrior::Config.out_stream = io
    RubyWarrior::Config.in_stream = io
    RubyWarrior::Game.new.start
  end
end

When /^I run rubywarrior with options "([^\"]*)"$/ do |options|
  RubyWarrior::Config.reset
  @io = MockIO.new
  @io.start do |io|
    RubyWarrior::Runner.new(options.split, io, io).run
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
  expect(@io.gets_until_include(phrase)).to include(phrase)
end

Then /^I should not see "([^\"]*)" before "([^\"]*)"$/ do |first_phrase, second_phrase|
  expect(@io.gets_until_include(second_phrase)).to_not include(first_phrase)
end
