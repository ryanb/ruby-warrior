require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Sludge do
  before(:each) do
    @sludge = RubyWarrior::Units::Sludge.new
  end
  
  it "should have attack action" do
    @sludge.abilities.keys.should include(:attack!)
  end
  
  it "should have feel sense" do
    @sludge.abilities.keys.should include(:feel)
  end
  
  it "should have attack power of 2" do
    @sludge.attack_power.should == 2
  end
  
  it "should have 8 max health" do
    @sludge.max_health.should == 8
  end
end
