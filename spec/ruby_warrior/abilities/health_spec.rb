require_relative '../../spec_helper'

describe RubyWarrior::Abilities::Health do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
    @health = RubyWarrior::Abilities::Health.new(@warrior)
  end
  
  it "should return the amount of health" do
    @warrior.health = 10
    @health.perform.should == 10
  end
end
