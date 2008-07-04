require 'rubygems'
require 'spec'
$: << File.dirname(__FILE__) + '/../lib'
require 'ruby_warrior'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
