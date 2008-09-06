require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Distance do
  before(:each) do
    @position = stub
    @distance = RubyWarrior::Abilities::Distance.new(stub(:position => @position, :say => nil))
  end
  
  it "should return distance from stairs" do
    @position.stubs(:distance_from_stairs).returns(5)
    @distance.perform.should == 5
  end
end
