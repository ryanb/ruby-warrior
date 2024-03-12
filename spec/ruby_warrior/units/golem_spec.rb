require 'spec_helper'

describe RubyWarrior::Units::Golem do
  before(:each) do
    @golem = RubyWarrior::Units::Golem.new
  end

  it "should execute turn proc when playing turn" do
    proc = Object.new
    expect(proc).to receive(:call).with(:turn)
    @golem.turn = proc
    @golem.play_turn(:turn)
  end

  it "should set max health and update current health" do
    @golem.max_health = 10
    expect(@golem.max_health).to eq(10)
    expect(@golem.health).to eq(10)
  end

  it "should have attack power of 3" do
    expect(@golem.attack_power).to eq(3)
  end

  it "should appear as G on map" do
    expect(@golem.character).to eq("G")
  end
end
