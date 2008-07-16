require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Rescue do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
    @rescue = RubyWarrior::Abilities::Rescue.new(@warrior)
  end
  
  it "should rescue captive" do
    captive = RubyWarrior::Units::Captive.new
    captive.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => true))
    @rescue.expects(:unit).with(:forward).returns(captive)
    @warrior.expects(:earn_points).with(20)
    @rescue.perform
    captive.position.should be_nil
  end
  
  it "should do nothing to other unit" do
    unit = RubyWarrior::Units::Base.new
    unit.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => false))
    @rescue.expects(:unit).with(:forward).never
    @warrior.expects(:earn_points).never
    @rescue.perform
    unit.position.should_not be_nil
  end
end
