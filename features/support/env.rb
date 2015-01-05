require 'cucumber'
require 'rspec'

require File.dirname(__FILE__) + '/../../lib/ruby_warrior'

Before {RubyWarrior::Config.reset}

After {FileUtils.rm_rf "towers/short"}
