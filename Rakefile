require 'rake'
require 'spec'
require 'cucumber'

require 'cucumber/rake/task'
require 'spec/rake/spectask'


spec_files = Rake::FileList["spec/**/*_spec.rb"]

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = spec_files
  t.spec_opts = ["-c"]
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format progress"
end

task :default => [:spec, :features]
