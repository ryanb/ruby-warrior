require 'spec_helper'

describe RubyWarrior::Abilities::Shoot do
  before(:each) do
    @shooter = double(:position => double, :shoot_power => 2, :say => nil)
    @shoot = RubyWarrior::Abilities::Shoot.new(@shooter)
  end

  it "should shoot only first unit" do
    receiver = double(:alive? => true)
    expect(receiver).to receive(:take_damage).with(2)
    other = double(:alive? => true)
    expect(other).to receive(:take_damage).never
    expect(@shoot).to receive(:multi_unit).with(:forward, anything).and_return([nil, receiver, other, nil])
    @shoot.perform
  end

  it "should shoot and do nothing if no units in the way" do
    expect(@shoot).to receive(:multi_unit).with(:forward, anything).and_return([nil, nil])
    expect { @shoot.perform }.to_not raise_error
  end
end
