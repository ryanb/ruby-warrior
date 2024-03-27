require "spec_helper"

describe RubyWarrior::Abilities::DistanceOf do
  before(:each) do
    @position = double
    @distance = RubyWarrior::Abilities::DistanceOf.new(double(position: @position, say: nil))
  end

  it "should return distance from stairs" do
    allow(@position).to receive(:distance_of).with(:space).and_return(5)
    expect(@distance.perform(:space)).to eq(5)
  end
end
