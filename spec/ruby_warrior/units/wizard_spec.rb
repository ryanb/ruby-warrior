require 'spec_helper'

describe RubyWarrior::Units::Wizard do
  before(:each) do
    @wizard = RubyWarrior::Units::Wizard.new
  end
  
  it "should have look and shoot abilities" do
    expect(@wizard.abilities.keys.to_set).to eq([:shoot!, :look].to_set)
  end
  
  it "should have shoot power of 11" do
    expect(@wizard.shoot_power).to eq(11)
  end
  
  it "should have 3 max health" do
    expect(@wizard.max_health).to eq(3)
  end
  
  it "should appear as w on map" do
    expect(@wizard.character).to eq("w")
  end
end
