require_relative '../../spec_helper'

describe RubyWarrior::Units::Wizard do
  before(:each) do
    @wizard = RubyWarrior::Units::Wizard.new
  end
  
  it "should have look and shoot abilities" do
    @wizard.abilities.keys.to_set.should == [:shoot!, :look].to_set
  end
  
  it "should have shoot power of 11" do
    @wizard.shoot_power.should == 11
  end
  
  it "should have 3 max health" do
    @wizard.max_health.should == 3
  end
  
  it "should appear as w on map" do
    @wizard.character.should == "w"
  end
end
