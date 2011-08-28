require_relative '../../spec_helper'

describe RubyWarrior::Abilities::Listen do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
    @warrior = RubyWarrior::Units::Warrior.new
    @floor.add(@warrior, 0, 0)
    @listen = RubyWarrior::Abilities::Listen.new(@warrior)
  end
  
  it "should return an array of spaces which have units on them besides main unit" do
    @floor.add(RubyWarrior::Units::Base.new, 0, 1)
    @listen.perform.should have(1).record
  end
end
