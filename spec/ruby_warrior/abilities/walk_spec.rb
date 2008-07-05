require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Warrior do
  before(:each) do
    @position = stub
    @walk = RubyWarrior::Abilities::Walk.new(stub(:position => @position))
  end
  
  it "should move position forward when calling perform" do
    @position.expects(:move).with(1, 0)
    @walk.perform
  end
  
  it "should move position right if that is direction" do
    @position.expects(:move).with(0, 1)
    @walk.perform(:right)
  end
  
  it "should have back and left directions" do
    RubyWarrior::Abilities::Walk::DIRECTIONS[:back].should == [-1, 0]
    RubyWarrior::Abilities::Walk::DIRECTIONS[:left].should == [0, -1]
  end
end
