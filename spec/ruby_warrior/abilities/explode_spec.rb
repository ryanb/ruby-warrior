require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Explode do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
    @captive = RubyWarrior::Units::Captive.new
    @floor.add(@captive, 0, 0)
    @explode = RubyWarrior::Abilities::Explode.new(@captive)
  end
  
  it "should subtract 100 health from each unit on the floor" do
    unit = RubyWarrior::Units::Base.new
    unit.health = 20
    @floor.add(unit, 0, 1)
    @captive.health = 10
    @explode.perform
    @captive.health.should == -90
    unit.health.should == -80
  end
end
