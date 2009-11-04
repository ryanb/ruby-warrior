require 'cucumber'
require 'spec'

require File.dirname(__FILE__) + '/../../lib/ruby_warrior'

Before do
  RubyWarrior::Config.reset
end

After do
  FileUtils.rm_rf "towers/short"
end
