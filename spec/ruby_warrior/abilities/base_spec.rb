require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Base do
  before(:each) do
    @unit = stub
    @ability = RubyWarrior::Abilities::Base.new(@unit)
  end
  
  it "should have offset for directions" do
    @ability.offset(:forward).should == [1, 0]
    @ability.offset(:right).should == [0, 1]
    @ability.offset(:back).should == [-1, 0]
    @ability.offset(:left).should == [0, -1]
  end
end
