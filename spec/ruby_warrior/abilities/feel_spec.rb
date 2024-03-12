require 'spec_helper'

describe RubyWarrior::Abilities::Feel do
  before(:each) do
    @unit = double(:position => double, :say => nil)
    @feel = RubyWarrior::Abilities::Feel.new(@unit)
  end
  
  it "should get object at position from offset" do
    expect(@unit.position).to receive(:relative_space).with(1, 0)
    @feel.perform(:forward)
  end
end
