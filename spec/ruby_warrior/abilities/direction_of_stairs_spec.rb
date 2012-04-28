require_relative '../../spec_helper'

describe RubyWarrior::Abilities::DirectionOfStairs do
  before(:each) do
    @position = stub
    @distance = RubyWarrior::Abilities::DirectionOfStairs.new(stub(:position => @position, :say => nil))
  end
  
  it "should return relative direction of stairs" do
    @position.stubs(:relative_direction_of_stairs).returns(:left)
    @distance.perform.should == :left
  end
end
