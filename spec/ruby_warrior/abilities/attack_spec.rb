require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Attack do
  before(:each) do
    @attacker = stub(:position => stub, :attack_power => 3, :say => nil)
    @attack = RubyWarrior::Abilities::Attack.new(@attacker)
  end
  
  it "should subtract attack power amount from health" do
    receiver = RubyWarrior::Units::Base.new
    receiver.health = 5
    @attack.stubs(:unit).returns(receiver)
    @attack.perform
    receiver.health.should == 2
  end
  
  it "should do nothing if recipient doesn't respond to take damage" do
    @attack.stubs(:unit).returns(Object.new)
    lambda { @attack.perform }.should_not raise_error(Exception)
  end
  
  it "should get object at position from offset" do
    @attacker.position.expects(:relative_space).with(1, 0)
    @attack.space(:forward)
  end
end
