require 'spec_helper'

describe RubyWarrior::Abilities::DirectionOf do
  before(:each) do
    @position = double
    @distance = RubyWarrior::Abilities::DirectionOf.new(double(:position => @position, :say => nil))
  end

  it "should return relative direction of given space" do
    allow(@position).to receive(:relative_direction_of).with(:space).and_return(:left)
    expect(@distance.perform(:space)).to eq(:left)
  end
end
