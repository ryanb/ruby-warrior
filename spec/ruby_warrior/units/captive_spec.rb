require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @captive = RubyWarrior::Units::Captive.new
  end
  
  it "should have 1 max health" do
    @captive.max_health.should == 1
  end
end
