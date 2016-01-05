require 'spec_helper'

describe RubyWarrior::Abilities::Look do
  before(:each) do
    @unit = stub(:position => stub, :say => nil)
    @feel = RubyWarrior::Abilities::Look.new(@unit)
  end
  
  it "should get 3 objects at position from offset" do
    @unit.position.expects(:relative_space).with(1, 0).returns(1)
    @unit.position.expects(:relative_space).with(2, 0).returns(2)
    @unit.position.expects(:relative_space).with(3, 0).returns(3)
    expect(@feel.perform(:forward)).to eq([1, 2, 3])
  end
end
