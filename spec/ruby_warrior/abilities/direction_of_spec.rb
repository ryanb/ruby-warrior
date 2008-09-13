require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::DirectionOf do
  before(:each) do
    @position = stub
    @distance = RubyWarrior::Abilities::DirectionOf.new(stub(:position => @position, :say => nil))
  end
  
  it "should return relative direction of given space" do
    @position.stubs(:relative_direction_of).with(:space).returns(:left)
    @distance.perform(:space).should == :left
  end
end
