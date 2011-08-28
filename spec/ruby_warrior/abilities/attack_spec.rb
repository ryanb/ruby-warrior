require_relative '../../spec_helper'

describe RubyWarrior::Abilities::Attack do
  before(:each) do
    @attacker = stub(:position => stub, :attack_power => 3, :say => nil)
    @attack = RubyWarrior::Abilities::Attack.new(@attacker)
  end
  
  it "should subtract attack power amount from health" do
    receiver = RubyWarrior::Units::Base.new
    receiver.stubs(:alive?).returns(true)
    receiver.health = 5
    @attack.stubs(:unit).returns(receiver)
    @attack.perform
    receiver.health.should == 2
  end
  
  it "should do nothing if recipient is nil" do
    @attack.stubs(:unit).returns(nil)
    lambda { @attack.perform }.should_not raise_error
  end
  
  it "should get object at position from offset" do
    @attacker.position.expects(:relative_space).with(1, 0)
    @attack.space(:forward)
  end
  
  it "should award points when killing unit" do
    receiver = stub(:take_damage => nil, :max_health => 8, :alive? => false)
    @attack.stubs(:unit).returns(receiver)
    @attacker.expects(:earn_points).with(8)
    @attack.perform
  end
  
  it "should not award points when not killing unit" do
    receiver = stub(:max_health => 8, :alive? => true)
    receiver.expects(:take_damage)
    @attack.stubs(:unit).returns(receiver)
    @attacker.expects(:earn_points).never
    @attack.perform
  end
  
  it "should reduce attack power when attacking backward" do
    receiver = RubyWarrior::Units::Base.new
    receiver.stubs(:alive?).returns(true)
    receiver.health = 5
    @attack.stubs(:unit).returns(receiver)
    @attack.perform(:backward)
    receiver.health.should == 3
  end
end
