require "rubygems"
require "rspec"
require File.dirname(__FILE__) + "/../lib/ruby_warrior"

RSpec.configure do |config|
  config.before(:each) { RubyWarrior::Config.reset }
  config.raise_errors_for_deprecations!
end
