require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/ruby_warrior'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
