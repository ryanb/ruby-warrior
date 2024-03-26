Gem::Specification.new do |s|
  s.name        = "rubywarrior"
  s.version     = "0.2.0"
  s.author      = "Ryan Bates"
  s.email       = "ryan@railscasts.com"
  s.homepage    = "https://github.com/ryanb/ruby-warrior"
  s.summary     = "Game written in Ruby for learning Ruby."
  s.description = "You play as a warrior climbing a tall tower. On each floor you need to write a Ruby script to instruct the warrior to battle enemies, rescue captives, and reach the stairs."
  s.license     = "MIT"

  s.files        = Dir["{lib,spec,features,towers,templates,bin}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"
  s.executables  = ["rubywarrior"]

  s.required_rubygems_version = ">= 1.3.4"
end
