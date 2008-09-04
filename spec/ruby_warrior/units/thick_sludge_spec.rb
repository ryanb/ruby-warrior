require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @sludge = RubyWarrior::Units::ThickSludge.new
  end
  
  it "should have 24 max health" do
    @sludge.max_health.should == 24
  end
  
  it "should appear as S on map" do
    @sludge.to_map.should == "S"
  end
end
