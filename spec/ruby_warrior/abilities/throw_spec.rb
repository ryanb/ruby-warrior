require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Throw do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 3
    @floor.height = 3
    @warrior = RubyWarrior::Units::Warrior.new
    @floor.add(@warrior, 0, 0, :south)
    @throw = RubyWarrior::Abilities::Throw.new(@warrior)
  end
  
  it "should subtract 4 from unit two spaces forward and 2 from units surrounding that space" do
    target_unit = RubyWarrior::Units::Base.new
    target_unit.health = 15
    second_unit = RubyWarrior::Units::Base.new
    second_unit.health = 15
    @floor.add(target_unit, 0, 2)
    @floor.add(second_unit, 1, 2)
    @throw.perform
    target_unit.health.should == 11
    second_unit.health.should == 13
  end
  
  it "should subtract 4 from unit two spaces left and 2 from units surrounding that space" do
    target_unit = RubyWarrior::Units::Base.new
    target_unit.health = 15
    second_unit = RubyWarrior::Units::Base.new
    second_unit.health = 15
    @floor.add(target_unit, 2, 0)
    @floor.add(second_unit, 2, 1)
    @throw.perform(:left)
    target_unit.health.should == 11
    second_unit.health.should == 13
  end
  
  it "should detonate an explosive if any unit has one" do
    captive = RubyWarrior::Units::Captive.new
    captive.health = 1
    captive.add_abilities :explode!
    @floor.add(captive, 1, 2)
    @throw.perform
    captive.health.should == -99
    @warrior.health.should == -80
  end
end
