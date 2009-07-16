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
  content = @io.gets
  while !content.include?(question)
    begin
      content += @io.gets
    rescue MockIO::Timeout
      raise "Unable to find #{question} in #{content}"
    end
  end
  @io.puts(answer)
end

When /^I wait until it says "([^\"]*)"$/ do |saying|
  content = @io.gets
  while !content.include?(saying)
    begin
      content += @io.gets
    rescue MockIO::Timeout
      raise "Unable to find #{saying} in #{content}"
    end
  end
end

Then /^I should see "([^\"]*)"$/ do |saying|
  @io.gets.should include(saying)
end

Then /^I should find file at "([^\"]*)"$/ do |path|
  File.exist?("tmp/" + path).should be_true
end
