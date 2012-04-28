require 'spec_helper'

describe RubyWarrior::Abilities::DistanceOf do
  before(:each) do
    @position = stub
    @distance = RubyWarrior::Abilities::DistanceOf.new(stub(:position => @position, :say => nil))
  end
  
  it "should return distance from stairs" do
    @position.stubs(:distance_of).with(:space).returns(5)
    @distance.perform(:space).should == 5
  end
end
