require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Sludge do
  before(:each) do
    @sludge = RubyWarrior::Units::Sludge.new
  end
  
  it "should have attack ability" do
    @sludge.should respond_to(:attack!)
  end
  
  it "should have feel ability" do
    @sludge.should respond_to(:feel)
  end
  
  it "should have attack power of 2" do
    @sludge.attack_power.should == 2
  end
end
