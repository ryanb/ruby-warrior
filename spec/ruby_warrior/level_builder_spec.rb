require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::LevelBuilder do
  before(:each) do
    @builder = RubyWarrior::LevelBuilder.new
  end
  
  it "should build level with number, width, and height" do
    @builder.level(1, :width => 3, :height => 7)
    level = @builder.result
    level.number.should == 1
    level.width.should == 3
    level.height.should == 7
  end
  
  it "should be able to add description and tip" do
    @builder.level(1, :width => 3, :height => 7)
    @builder.description "foo"
    @builder.tip "bar"
    level = @builder.result
    level.description.should == "foo"
    level.tip.should == "bar"
  end
  
  it "should be able to add stairs" do
    @builder.level(1, :width => 3, :height => 7)
    @builder.stairs :x => 1, :y => 2
    level = @builder.result
    level.goal.should == [1, 2]
  end
  
  it "build on class should eval the file and return the result" do
    File.expects(:read).with('/foo/bar').returns("@level = 'level'")
    RubyWarrior::LevelBuilder.build('/foo/bar').should == 'level'
  end
end
