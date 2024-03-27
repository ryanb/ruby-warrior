require "rake"
require "rspec"
require "rspec/core/rake_task"
require "cucumber"
require "cucumber/rake/task"

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) { |t| t.pattern = "spec/**/*_spec.rb" }

Cucumber::Rake::Task.new(:features) { |t| t.cucumber_opts = %w[features] }

task default: %i[spec features]
