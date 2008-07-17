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
  
  it "should fetch unit at given direction with distance" do
    @ability.expects(:space).with(:right, 3).returns(stub(:unit => 'unit'))
    @ability.unit(:right, 3).should == 'unit'
  end
end
