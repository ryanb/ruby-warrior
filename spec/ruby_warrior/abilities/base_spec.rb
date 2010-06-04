require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Base do
  before(:each) do
    @unit = stub
    @ability = RubyWarrior::Abilities::Base.new(@unit)
  end
  
  it "should have offset for directions" do
    @ability.offset(:forward).should == [1, 0]
    @ability.offset(:right).should == [0, 1]
    @ability.offset(:backward).should == [-1, 0]
    @ability.offset(:left).should == [0, -1]
  end
  
  it "should have offset for relative forward/right amounts" do
    @ability.offset(:forward, 2).should == [2, 0]
    @ability.offset(:forward, 2, 1).should == [2, -1]
    @ability.offset(:right, 2, 1).should == [1, 2]
    @ability.offset(:backward, 2, 1).should == [-2, 1]
    @ability.offset(:left, 2, 1).should == [-1, -2]
  end
  
  it "should fetch unit at given direction with distance" do
    @ability.expects(:space).with(:right, 3, 1).returns(stub(:unit => 'unit'))
    @ability.unit(:right, 3, 1).should == 'unit'
  end
  
  it "should have no description" do
    @ability.description.should be_nil
  end
  
  it "should raise an exception if direction isn't recognized" do
    lambda {
      @ability.verify_direction(:foo)
    }.should raise_error("Unknown direction :foo. Should be :forward, :backward, :left or :right.")
  end
end
