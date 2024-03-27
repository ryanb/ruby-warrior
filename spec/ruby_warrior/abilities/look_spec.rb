require "spec_helper"

describe RubyWarrior::Abilities::Look do
  before(:each) do
    @unit = double(position: double, say: nil)
    @feel = RubyWarrior::Abilities::Look.new(@unit)
  end

  it "should get 3 objects at position from offset" do
    expect(@unit.position).to receive(:relative_space).with(1, 0).and_return(1)
    expect(@unit.position).to receive(:relative_space).with(2, 0).and_return(2)
    expect(@unit.position).to receive(:relative_space).with(3, 0).and_return(3)
    expect(@feel.perform(:forward)).to eq([1, 2, 3])
  end
end
