require 'cucumber'
require 'spec'

require File.dirname(__FILE__) + '/../../lib/ruby_warrior'

After do
  FileUtils.rm_rf "towers/short"
end
