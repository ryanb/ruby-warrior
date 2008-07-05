require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::PlayerGenerator do
  before(:each) do
    @level = RubyWarrior::Level.new(15, 2, 3)
    @generator = RubyWarrior::PlayerGenerator.new('/foo/bar', @level)
  end
  
  it "should generate level_name with zeros" do
    @generator.level_name.should == 'level-015'
  end
  
  it "should combine level and player path" do
    @generator.level_path.should == '/foo/bar/level-015'
  end
  
  it "should combine level, player path and append given path file" do
    @generator.level_path('/templates/test.js.erb').should == '/foo/bar/level-015/test.js'
  end
end
