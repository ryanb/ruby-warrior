require 'rake'
require 'spec'

require 'spec/rake/spectask'


spec_files = Rake::FileList["spec/**/*_spec.rb"]

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = spec_files
  t.spec_opts = ["-c"]
end

task :cucumber do
  system "cucumber features"
end

task :default => [:spec, :cucumber]
