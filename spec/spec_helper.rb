require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + '/../lib/ruby_warrior'

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:each) do
    RubyWarrior::Config.reset
  end
  config.raise_errors_for_deprecations!
end
