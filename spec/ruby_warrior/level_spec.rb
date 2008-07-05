require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Level do
  before(:each) do
    @level = RubyWarrior::Level.new(1, 2, 3)
  end
  
  it "should call turn on each object specified number of times" do
    object = RubyWarrior::Units::Warrior.new
    object.expects(:turn).times(2)
    @level.add(object, 0, 0, :north)
    @level.play(2)
  end
  
  it "should return immediately when passed" do
    object = RubyWarrior::Units::Warrior.new
    object.expects(:turn).times(0)
    @level.add(object, 0, 0, :north)
    @level.stubs(:passed?).returns(true)
    @level.play(2)
  end
  
  it "should consider passed when warrior is on goal" do
    @level.add(RubyWarrior::Units::Warrior.new, 0, 0, :north)
    @level.goal = [0, 0]
    @level.should be_passed
  end
  
  it "should yield to block in play method for each turn" do
    int = 0
    @level.play(2) do
      int += 1
    end
    int.should == 2
  end
end
