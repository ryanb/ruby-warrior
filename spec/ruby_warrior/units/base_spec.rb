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
    expect(@unit).to_not be_alive
  end

  it "should consider itself alive with position" do
    @unit.position = double
    expect(@unit).to be_alive
  end

  it "should default max health to 10" do
    expect(@unit.max_health).to be_zero
  end

  it "should do nothing when earning points" do
    expect { @unit.earn_points(10) }.to_not raise_error
  end

  it "should default health to max health" do
    allow(@unit).to receive(:max_health).and_return(10)
    expect(@unit.health).to eq(10)
  end

  it "should subtract health when taking damage" do
    allow(@unit).to receive(:max_health).and_return(10)
    @unit.take_damage(3)
    expect(@unit.health).to eq(7)
  end

  it "should do nothing when taking damage if health isn't set" do
    expect { @unit.take_damage(3) }.to_not raise_error
  end

  it "should set position to nil when running out of health" do
    @unit.position = double
    allow(@unit).to receive(:max_health).and_return(10)
    @unit.take_damage(10)
    expect(@unit.position).to be_nil
  end

  it "should print out line with name when speaking" do
    expect(RubyWarrior::UI).to receive(:puts_with_delay).with("Base foo")
    @unit.say "foo"
  end

  it "should return name in to_s" do
    expect(@unit.name).to eq('Base')
    expect(@unit.to_s).to eq('Base')
  end

  it "should prepare turn by calling play_turn with next turn object" do
    allow(@unit).to receive(:next_turn).and_return('next_turn')
    expect(@unit).to receive(:play_turn).with('next_turn')
    @unit.prepare_turn
  end

  it "should perform action when calling perform on turn" do
    @unit.position = double
    expect_any_instance_of(RubyWarrior::Abilities::Walk).to receive(:perform).with(:backward)
    @unit.add_abilities(:walk!)
    turn = double(:action => [:walk!, :backward])
    allow(@unit).to receive(:next_turn).and_return(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end

  it "should not perform action when dead (no position)" do
    @unit.position = nil
    allow_any_instance_of(RubyWarrior::Abilities::Walk).to receive(:perform).and_raise("action should not be called")
    @unit.add_abilities(:walk!)
    turn = double(:action => [:walk!, :backward])
    allow(@unit).to receive(:next_turn).and_return(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end

  it "should not raise an exception when calling perform_turn when there's no action" do
    @unit.prepare_turn
    expect { @unit.perform_turn }.to_not raise_error
  end

  it "should pass abilities to new turn when calling next_turn" do
    expect(RubyWarrior::Turn).to receive(:new).with({:walk! => nil, :attack! => nil, :feel => nil}).and_return('turn')
    allow(@unit).to receive(:abilities).and_return({:walk! => nil, :attack! => nil, :feel => nil})
    expect(@unit.next_turn).to eq('turn')
  end

  it "should add ability" do
    expect(RubyWarrior::Abilities::Walk).to receive(:new).with(@unit).and_return('walk')
    @unit.add_abilities(:walk!)
    expect(@unit.abilities).to eq({ :walk! => 'walk' })
  end

  it "should appear as question mark on map" do
    expect(@unit.character).to eq("?")
  end

  it "should be released from bonds when taking damage" do
    allow(@unit).to receive(:max_health).and_return(10)
    @unit.bind
    expect(@unit).to be_bound
    @unit.take_damage(2)
    expect(@unit).to_not be_bound
  end

  it "should be released from bonds when calling release" do
    @unit.bind
    @unit.unbind
    expect(@unit).to_not be_bound
  end

  it "should not perform action when bound" do
    @unit.position = double
    @unit.bind
    allow_any_instance_of(RubyWarrior::Abilities::Walk).to receive(:perform).and_raise("action should not be called")
    @unit.add_abilities(:walk!)
    turn = double(:action => [:walk!, :backward])
    allow(@unit).to receive(:next_turn).and_return(turn)
    @unit.prepare_turn
    @unit.perform_turn
  end
end
