require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Walk do
  before(:each) do
    @position = stub
    @walk = RubyWarrior::Walk.new(:forward)
    @walk.owner = stub(:position => @position)
  end
  
  it "should be subclass of Ability" do
    @walk.should be_kind_of(RubyWarrior::Ability)
  end
  
  it "should move position forward when calling act" do
    @position.expects(:move).with(1, 0)
    @walk.act
  end
  
  it "should move position right if that is direction" do
    @walk = RubyWarrior::Walk.new(:right)
    @walk.owner = stub(:position => @position)
    @position.expects(:move).with(0, 1)
    @walk.act
  end
  
  it "should have back and left directions" do
    RubyWarrior::Walk::DIRECTIONS[:back].should == [-1, 0]
    RubyWarrior::Walk::DIRECTIONS[:left].should == [0, -1]
  end
end
