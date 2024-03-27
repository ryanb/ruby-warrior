require 'rake'
require 'rspec'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = %w[features --format progress]
end

task :default => [:spec, :features]
