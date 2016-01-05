require 'spec_helper'

describe RubyWarrior::Abilities::Health do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
    @health = RubyWarrior::Abilities::Health.new(@warrior)
  end
  
  it "should return the amount of health" do
    @warrior.health = 10
    expect(@health.perform).to eq 10
  end
end
