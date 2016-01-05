require 'spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @sludge = RubyWarrior::Units::ThickSludge.new
  end
  
  it "should have 24 max health" do
    expect(@sludge.max_health).to eq(24)
  end
  
  it "should appear as S on map" do
    expect(@sludge.character).to eq("S")
  end
  
  it "should have the name of 'Thick Sludge'" do
    expect(@sludge.name).to eq("Thick Sludge")
  end
end
