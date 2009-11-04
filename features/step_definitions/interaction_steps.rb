Given /^a profile named "([^\"]*)" on "([^\"]*)"$/ do |name, tower|
  When 'I run rubywarrior'
  And 'I answer "y" to "create one?"'
  And 'I choose "' + tower + '" for "tower"'
  And 'I answer "' + name + '" to "name"'
  Then 'I should see "generated"'
end

Given /^no profile at "([^\"]*)"$/ do |path|
  RubyWarrior::Config.path_prefix = path
  FileUtils.rm_rf("#{path}/ruby-warrior")
end

Given /^current directory is "([^\"]*)"$/ do |path|
  RubyWarrior::Config.path_prefix = path
end

When /^I run rubywarrior$/ do
  @io = MockIO.new
  @io.start do |io|
    RubyWarrior::UI.out_stream = io
    RubyWarrior::UI.in_stream = io
    RubyWarrior::Game.new.start
  end
end

When /^I run rubywarrior with options "([^\"]*)"$/ do |options|
  @io = MockIO.new
  @io.start do |io|
    RubyWarrior::UI.out_stream = io
    RubyWarrior::UI.in_stream = io
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
  @io.gets_until_include(phrase).should include(phrase)
end
