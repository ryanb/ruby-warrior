require 'spec_helper'

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
  
  it "should have attack power of 3" do
    @sludge.attack_power.should == 3
  end
  
  it "should have 12 max health" do
    @sludge.max_health.should == 12
  end
  
  it "should appear as s on map" do
    @sludge.character.should == "s"
  end
end
