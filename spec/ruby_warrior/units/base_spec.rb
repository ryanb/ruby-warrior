require 'spec_helper'

describe RubyWarrior::Units::Base do
  before(:each) do
    @unit = RubyWarrior::Units::Base.new
  end
  
  it "should have an attack power which defaults to zero" do
    expect(@unit.attack_power).to be_zero
  end
  
  it "should consider itself dead when no position" do
    expect(@unit.position).to be_nil
    expect(@unit).not_to be_alive
  end
  
  it "should consider itself alive with position" do
    @unit.position = stub
    expect(@unit).to be_alive
  end
  
  it "should default max health to 10" do
    expect(@unit.max_health).to be_zero
  end
  
  it "should do nothing when earning points" do
    expect(lambda { @unit.earn_points(10) }).not_to raise_error
  end
  
  it "should default health to max health" do
    @unit.stubs(:max_health).returns(10)
    expect(@unit.health).to eq(10)
  end
  
  it "should subtract health when taking damage" do
    @unit.stubs(:max_health).returns(10)
    @unit.take_damage(3)
    expect(@unit.health).to eq(7)
  end
  
  it "should do nothing when taking damage if health isn't set" do
    expect(lambda { @unit.take_damage(3) }).not_to raise_error
  end
  
  it "should set position to nil when running out of health" do
    @unit.position = stub
    @unit.stubs(:max_health).returns(10)
    @unit.take_damage(10)
    expect(@unit.position).to be_nil
  end
  
  it "should print out line with name when speaking" do
    RubyWarrior::UI.expects(:puts_with_delay).with("Base foo")
    @unit.say "foo"
  end
  
  it "should return name in to_s" do
    expect(@unit.name).to eq('Base')
    expect(@unit.to_s).to eq('Base')
  end
  
  it "should prepare turn by calling play_turn with next turn object" do
    @unit.stubs(:next_turn).returns('next_turn')
    @unit.expects(:play_turn).with('next_turn')
    @unit.prepare_turn
  end
  
  it "should perform action when calling perform on turn" do
    @unit.position = stub
    RubyWarrior::Abilities::Walk.any_instance.expects(:perform).with(:backward)
    @unit.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :backward])
    @unit.stubs(:next_turn).returns(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
  
  it "should not perform action when dead (no position)" do
    @unit.position = nil
    RubyWarrior::Abilities::Walk.any_instance.stubs(:perform).raises("action should not be called")
    @unit.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :backward])
    @unit.stubs(:next_turn).returns(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
  
  it "should not raise an exception when calling perform_turn when there's no action" do
    @unit.prepare_turn
    expect(lambda { @unit.perform_turn }).not_to raise_error
  end
  
  it "should pass abilities to new turn when calling next_turn" do
    RubyWarrior::Turn.expects(:new).with(:walk! => nil, :attack! => nil, :feel => nil).returns('turn')
    @unit.stubs(:abilities).returns(:walk! => nil, :attack! => nil, :feel => nil)
    expect(@unit.next_turn).to eq('turn')
  end
  
  it "should add ability" do
    RubyWarrior::Abilities::Walk.expects(:new).with(@unit).returns('walk')
    @unit.add_abilities(:walk!)
    expect(@unit.abilities).to eq({ :walk! => 'walk' })
  end
  
  it "should appear as question mark on map" do
    expect(@unit.character).to eq("?")
  end
  
  it "should be released from bonds when taking damage" do
    @unit.stubs(:max_health).returns(10)
    @unit.bind
    expect(@unit).to be_bound
    @unit.take_damage(2)
    expect(@unit).not_to be_bound
  end
  
  it "should be released from bonds when calling release" do
    @unit.bind
    @unit.unbind
    expect(@unit).not_to be_bound
  end
  
  it "should not perform action when bound" do
    @unit.position = stub
    @unit.bind
    RubyWarrior::Abilities::Walk.any_instance.stubs(:perform).raises("action should not be called")
    @unit.add_abilities(:walk!)
    turn = stub(:action => [:walk!, :backward])
    @unit.stubs(:next_turn).returns(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
end
