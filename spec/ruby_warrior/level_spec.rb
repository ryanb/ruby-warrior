require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Level do
  before(:each) do
    @level = RubyWarrior::Level.new(1, 2, 3)
  end
  
  it "should call turn number of times passed" do
    object = stub
    object.expects(:turn).times(2)
    floor = stub(:objects => [object])
    @level.stubs(:floor).returns(floor)
    @level.play(2)
  end
end
