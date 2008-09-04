require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Floor do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
  end
  
  it "should be able to add a unit and fetch it at that position" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1, :north)
    @floor.get(0, 1).should == unit
  end
  
  it "should not consider unit on floor if no position" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1, :north)
    unit.position = nil
    @floor.units.should_not include(unit)
  end
  
  it "should fetch other units not warrior" do
    unit = RubyWarrior::Units::Base.new
    warrior = RubyWarrior::Units::Warrior.new
    @floor.add(unit, 0, 0, :north)
    @floor.add(warrior, 1, 0, :north)
    @floor.other_units.should_not include(warrior)
    @floor.other_units.should include(unit)
  end
  
  it "should not consider corners out of bounds" do
    @floor.should_not be_out_of_bounds(0, 0)
    @floor.should_not be_out_of_bounds(1, 0)
    @floor.should_not be_out_of_bounds(1, 2)
    @floor.should_not be_out_of_bounds(0, 2)
  end
  
  it "should consider out of bounds when going beyond sides" do
    @floor.should be_out_of_bounds(-1, 0)
    @floor.should be_out_of_bounds(0, -1)
    @floor.should be_out_of_bounds(0, 3)
    @floor.should be_out_of_bounds(2, 0)
  end
  
  it "should return space at the specified location" do
    @floor.space(0, 0).should be_kind_of(RubyWarrior::Space)
  end
  
  it "should place stairs and be able to fetch the location" do
    @floor.place_stairs(1, 2)
    @floor.stairs_location.should == [1, 2]
  end
  
  it "should print empty floor in ascii" do
    @floor.to_map.should == <<-MAP
 --
|  |
|  |
|  |
 --
MAP
  end
end
