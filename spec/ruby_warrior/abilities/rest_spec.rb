require_relative '../../spec_helper'

describe RubyWarrior::Abilities::Rest do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
    @rest = RubyWarrior::Abilities::Rest.new(@warrior)
  end
  
  it "should give 10% health back" do
    @warrior.stubs(:max_health).returns(20)
    @warrior.health = 10
    @rest.perform
    @warrior.health.should == 12
  end
  
  it "should add health when at max" do
    @warrior.stubs(:max_health).returns(20)
    @warrior.health = 20
    @rest.perform
    @warrior.health.should == 20
  end
  
  it "should not go over max health" do
    @warrior.stubs(:max_health).returns(20)
    @warrior.health = 19
    @rest.perform
    @warrior.health.should == 20
  end
end
