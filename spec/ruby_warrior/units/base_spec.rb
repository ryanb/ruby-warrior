require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Base do
  before(:each) do
    @unit = RubyWarrior::Units::Base.new
  end
  
  it "should have an attack power which defaults to zero" do
    @unit.attack_power.should be_zero
  end
  
  it "should consider itself dead when no position" do
    @unit.position.should be_nil
    @unit.should_not be_alive
  end
  
  it "should consider itself alive with position" do
    @unit.position = stub
    @unit.should be_alive
  end
  
  it "should default max health to 10" do
    @unit.max_health.should be_zero
  end
  
  it "should do nothing when earning points" do
    lambda { @unit.earn_points(10) }.should_not raise_error
  end
  
  it "should default health to max health" do
    @unit.stubs(:max_health).returns(10)
    @unit.health.should == 10
  end
  
  it "should subtract health when taking damage" do
    @unit.stubs(:max_health).returns(10)
    @unit.take_damage(3)
    @unit.health.should == 7
  end
  
  it "should do nothing when taking damage if health isn't set" do
    lambda { @unit.take_damage(3) }.should_not raise_error(Exception)
  end
  
  it "should set position to nil when running out of health" do
    @unit.position = stub
    @unit.stubs(:max_health).returns(10)
    @unit.take_damage(10)
    @unit.position.should be_nil
  end
  
  it "should print out line with name when speaking" do
    RubyWarrior::UI.expects(:puts).with("Base foo")
    @unit.say "foo"
  end
  
  it "should return name in to_s" do
    @unit.name.should == 'Base'
    @unit.to_s.should == 'Base'
  end
  
  it "should prepare turn by calling play_turn with next turn object" do
    @unit.stubs(:next_turn).returns('next_turn')
    @unit.expects(:play_turn).with('next_turn')
    @unit.prepare_turn
  end
  
  it "should perform action when calling perform on turn" do
    @unit.position = stub
    RubyWarrior::Abilities::Walk.any_instance.expects(:perform).with(:back)
    @unit.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :back])
    @unit.stubs(:next_turn).returns(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
  
  it "should not perform action when dead (no position)" do
    @unit.position = nil
    RubyWarrior::Abilities::Walk.any_instance.stubs(:perform).raises("action should not be called")
    @unit.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :back])
    @unit.stubs(:next_turn).returns(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
  
  it "should not raise an exception when calling perform_turn when there's no action" do
    @unit.prepare_turn
    lambda { @unit.perform_turn }.should_not raise_error(Exception)
  end
  
  it "should pass abilities to new turn when calling next_turn" do
    RubyWarrior::Turn.expects(:new).with(:walk! => nil, :attack! => nil, :feel => nil).returns('turn')
    @unit.stubs(:abilities).returns(:walk! => nil, :attack! => nil, :feel => nil)
    @unit.next_turn.should == 'turn'
  end
  
  it "should add ability" do
    RubyWarrior::Abilities::Walk.expects(:new).with(@unit).returns('walk')
    @unit.add_abilities(:walk!)
    @unit.abilities.should == { :walk! => 'walk' }
  end
end
