require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Detonate do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 3
    @floor.height = 3
    @warrior = RubyWarrior::Units::Warrior.new
    @floor.add(@warrior, 0, 0, :south)
    @detonate = RubyWarrior::Abilities::Detonate.new(@warrior)
  end
  
  it "should subtract 8 from forward unit and 4 from surrounding units" do
    target_unit = RubyWarrior::Units::Base.new
    target_unit.health = 15
    second_unit = RubyWarrior::Units::Base.new
    second_unit.health = 15
    @floor.add(target_unit, 0, 1)
    @floor.add(second_unit, 1, 1)
    @detonate.perform
    target_unit.health.should == 7
    second_unit.health.should == 11
  end
  
  it "should subtract 8 from left unit and 4 from surrounding units" do
    target_unit = RubyWarrior::Units::Base.new
    target_unit.health = 15
    second_unit = RubyWarrior::Units::Base.new
    second_unit.health = 15
    @floor.add(target_unit, 1, 0)
    @floor.add(second_unit, 1, 1)
    @detonate.perform(:left)
    target_unit.health.should == 7
    second_unit.health.should == 11
  end
  
  it "should detonate an explosive if any unit has one" do
    captive = RubyWarrior::Units::Captive.new
    captive.health = 1
    captive.add_abilities :explode!
    @floor.add(captive, 1, 1)
    @detonate.perform
    captive.health.should == -99
    @warrior.health.should == -80
  end
end
