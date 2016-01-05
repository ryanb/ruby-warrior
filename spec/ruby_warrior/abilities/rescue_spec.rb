require 'spec_helper'

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
    expect(captive.position).to be_nil
  end
  
  it "should do nothing to other unit if not bound" do
    unit = RubyWarrior::Units::Base.new
    unit.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => false))
    @rescue.expects(:unit).with(:forward).never
    @warrior.expects(:earn_points).never
    @rescue.perform
    expect(unit.position).not_to be_nil
  end
  
  it "should release other unit when bound" do
    unit = RubyWarrior::Units::Base.new
    unit.bind
    unit.position = stub
    @rescue.expects(:space).with(:forward).returns(stub(:captive? => true))
    @rescue.expects(:unit).with(:forward).returns(unit)
    @warrior.expects(:earn_points).never
    @rescue.perform
    expect(unit).not_to be_bound
    expect(unit.position).not_to be_nil
  end
end
