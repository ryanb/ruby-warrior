require_relative '../../spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @sludge = RubyWarrior::Units::ThickSludge.new
  end
  
  it "should have 24 max health" do
    @sludge.max_health.should == 24
  end
  
  it "should appear as S on map" do
    @sludge.character.should == "S"
  end
  
  it "should have the name of 'Thick Sludge'" do
    @sludge.name.should == "Thick Sludge"
  end
end
