require 'spec_helper'

describe RubyWarrior::Abilities::Shoot do
  before(:each) do
    @shooter = stub(:position => stub, :shoot_power => 2, :say => nil)
    @shoot = RubyWarrior::Abilities::Shoot.new(@shooter)
  end

  it "should shoot only first unit" do
    receiver = stub(:alive? => true)
    receiver.expects(:take_damage).with(2)
    other = stub(:alive? => true)
    other.expects(:take_damage).never
    @shoot.expects(:multi_unit).with(:forward, anything).returns([nil, receiver, other, nil])
    @shoot.perform
  end

  it "should shoot and do nothing if no units in the way" do
    @shoot.expects(:multi_unit).with(:forward, anything).returns([nil, nil])
    expect { @shoot.perform }.to_not raise_error
  end
end
