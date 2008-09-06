require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @captive = RubyWarrior::Units::Captive.new
  end
  
  it "should have 1 max health" do
    @captive.max_health.should == 1
  end
  
  it "should appear as C on map" do
    @captive.to_map.should == "C"
  end
  
  it "should be bound by default" do
    @captive.should be_bound
  end
end
