require File.dirname(__FILE__) + '/../../spec_helper'

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
end
