require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Floor do
  before(:each) do
    @floor = RubyWarrior::Floor.new(2, 3)
  end
  
  it "should be able to add a unit and fetch it at that position" do
    unit = RubyWarrior::Units::Warrior.new
    @floor.add(unit, 0, 1, :north)
    @floor.get(0, 1).should == unit
  end
  
  it "should not consider unit on floor if no position" do
    unit = RubyWarrior::Units::Warrior.new
    @floor.add(unit, 0, 1, :north)
    unit.position = nil
    @floor.units.should_not include(unit)
  end
end
