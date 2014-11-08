require 'rubygems'
require 'rspec'
require File.dirname(__FILE__) + '/../lib/ruby_warrior'

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:each) do
    RubyWarrior::Config.reset
  end
  config.expect_with :rspec do |c|
    c.syntax = [:should]
  end
end
