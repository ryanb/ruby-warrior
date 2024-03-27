require "spec_helper"

describe RubyWarrior::Abilities::Attack do
  before(:each) do
    @attacker = double(position: double, attack_power: 3, say: nil)
    @attack = RubyWarrior::Abilities::Attack.new(@attacker)
  end

  it "should subtract attack power amount from health" do
    receiver = RubyWarrior::Units::Base.new
    allow(receiver).to receive(:alive?).and_return(true)
    receiver.health = 5
    allow(@attack).to receive(:unit).and_return(receiver)
    @attack.perform
    expect(receiver.health).to eq(2)
  end

  it "should do nothing if recipient is nil" do
    allow(@attack).to receive(:unit).and_return(nil)
    expect { @attack.perform }.to_not raise_error
  end

  it "should get object at position from offset" do
    expect(@attacker.position).to receive(:relative_space).with(1, 0)
    @attack.space(:forward)
  end

  it "should award points when killing unit" do
    receiver = double(take_damage: nil, max_health: 8, alive?: false)
    allow(@attack).to receive(:unit).and_return(receiver)
    expect(@attacker).to receive(:earn_points).with(8)
    @attack.perform
  end

  it "should not award points when not killing unit" do
    receiver = double(max_health: 8, alive?: true)
    expect(receiver).to receive(:take_damage)
    allow(@attack).to receive(:unit).and_return(receiver)
    expect(@attacker).to receive(:earn_points).never
    @attack.perform
  end

  it "should reduce attack power when attacking backward" do
    receiver = RubyWarrior::Units::Base.new
    allow(receiver).to receive(:alive?).and_return(true)
    receiver.health = 5
    allow(@attack).to receive(:unit).and_return(receiver)
    @attack.perform(:backward)
    expect(receiver.health).to eq(3)
  end
end
