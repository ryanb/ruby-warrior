require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Explode do
  before(:each) do
    @captive = RubyWarrior::Units::Captive.new
    @explode = RubyWarrior::Abilities::Explode.new(@captive)
  end
  
  it "should set health to 0" do
    @captive.position = stub
    @captive.health = 10
    @explode.perform
    @captive.health.should == 0
  end
  
  it "should do nothing if no position" do
    @captive.health = 10
    @explode.perform
    @captive.health.should == 10
  end
end
