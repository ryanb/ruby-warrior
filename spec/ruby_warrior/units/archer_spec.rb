require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Archer do
  before(:each) do
    @archer = RubyWarrior::Units::Archer.new
  end
  
  it "should have look and shoot abilities" do
    @archer.abilities.keys.to_set.should == [:shoot!, :look].to_set
  end
  
  it "should have shoot power of 3" do
    @archer.shoot_power.should == 3
  end
  
  it "should have 7 max health" do
    @archer.max_health.should == 7
  end
  
  it "should appear as a on map" do
    @archer.to_map.should == "a"
  end
end
