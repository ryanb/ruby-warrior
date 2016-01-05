require 'spec_helper'

describe RubyWarrior::Units::Sludge do
  before(:each) do
    @sludge = RubyWarrior::Units::Sludge.new
  end
  
  it "should have attack action" do
    expect(@sludge.abilities.keys).to include(:attack!)
  end
  
  it "should have feel sense" do
    expect(@sludge.abilities.keys).to include(:feel)
  end
  
  it "should have attack power of 3" do
    expect(@sludge.attack_power).to eq(3)
  end
  
  it "should have 12 max health" do
    expect(@sludge.max_health).to eq(12)
  end
  
  it "should appear as s on map" do
    expect(@sludge.character).to eq("s")
  end
end
