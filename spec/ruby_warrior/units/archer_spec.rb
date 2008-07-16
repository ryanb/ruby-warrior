require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Archer do
  before(:each) do
    @sludge = RubyWarrior::Units::Archer.new
  end
  
  it "should have look and shoot abilities" do
    @sludge.abilities.keys.to_set.should == [:shoot!, :look].to_set
  end
  
  it "should have shoot power of 3" do
    @sludge.shoot_power.should == 3
  end
  
  it "should have 7 max health" do
    @sludge.max_health.should == 7
  end
end
