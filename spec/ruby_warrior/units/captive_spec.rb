require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::ThickSludge do
  before(:each) do
    @captive = RubyWarrior::Units::Captive.new
  end
  
  it "should have 1 max health" do
    @captive.max_health.should == 1
  end
  
  it "should appear as C on map" do
    @captive.character.should == "C"
  end
  
  it "should be bound by default" do
    @captive.should be_bound
  end
  
  it "should explode when bomb time reaches 0 and unbind itself" do
    @captive.bomb_time = 3
    @captive.play_turn(stub)
    @captive.play_turn(stub)
    @captive.should be_bound
    turn = stub
    turn.expects(:explode!)
    @captive.play_turn(turn)
    @captive.should_not be_bound
  end
  
  it "should have explode ability" do
    @captive.abilities.keys.should include(:explode!)
  end
end
