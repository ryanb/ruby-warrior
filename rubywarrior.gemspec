Gem::Specification.new do |s|
  s.name = "rubywarrior"
  s.summary = "Game written in Ruby for learning Ruby and artificial intelligence."
  s.description = "You play as a warrior climbing a tall tower. On each floor you need to write a Ruby script to instruct the warrior to battle enemies, rescue captives, and reach the stairs."
  s.homepage = "http://github.com/ryanb/ruby-warrior"
  
  s.version = "0.1.0"
  s.date = "2010-01-02"
  
  s.authors = ["Ryan Bates"]
  s.email = "ryan@railscasts.com"
  
  s.require_paths = ["lib"]
  s.files = Dir["lib/**/*"] + Dir["spec/**/*"] + Dir["features/**/*"] + Dir["towers/**/*"] + Dir["templates/**/*"] + ["bin/rubywarrior", "LICENSE", "README.rdoc", "Rakefile", "CHANGELOG.rdoc"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc", "LICENSE"]
  s.executables = ["rubywarrior"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "RubyWarrior", "--main", "README.rdoc"]
  
  s.rubygems_version = "1.3.4"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
end
