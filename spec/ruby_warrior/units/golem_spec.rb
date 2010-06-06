require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Golem do
  before(:each) do
    @golem = RubyWarrior::Units::Golem.new
  end
  
  it "should execute turn proc when playing turn" do
    proc = Object.new
    proc.expects(:call).with(:turn)
    @golem.turn = proc
    @golem.play_turn(:turn)
  end
  
  it "should set max health and update current health" do
    @golem.max_health = 10
    @golem.max_health.should == 10
    @golem.health.should == 10
  end
  
  it "should have attack power of 3" do
    @golem.attack_power.should == 3
  end
  
  it "should appear as G on map" do
    @golem.character.should == "G"
  end
end
