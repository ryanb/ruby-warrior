require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Level do
  before(:each) do
    @level = RubyWarrior::Level.new(1, 2, 3)
  end
  
  it "should call turn on each object specified number of times" do
    object = stub
    object.expects(:turn).times(2)
    @level.add(object, 0, 0)
    @level.play(2)
  end
  
  it "should return immediately when passed" do
    object = stub
    object.expects(:turn).times(0)
    @level.add(object, 0, 0)
    @level.stubs(:passed?).returns(true)
    @level.play(2)
  end
  
  it "should consider passed when warrior is on goal" do
    @level.add(RubyWarrior::Warrior.new, 0, 0)
    @level.goal = [0, 0]
    @level.should be_passed
  end
end
