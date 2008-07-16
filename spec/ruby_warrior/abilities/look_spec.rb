require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Look do
  before(:each) do
    @unit = stub(:position => stub, :say => nil)
    @feel = RubyWarrior::Abilities::Look.new(@unit)
  end
  
  it "should get 3 objects at position from offset" do
    @unit.position.expects(:relative_space).with(1, 0).returns(1)
    @unit.position.expects(:relative_space).with(2, 0).returns(2)
    @unit.position.expects(:relative_space).with(3, 0).returns(3)
    @feel.perform(:forward).should == [1, 2, 3]
  end
  
  it "should have all directions except back as possible arguments" do
    @feel.possible_arguments.to_set.should == [[], :forward, :left, :right].to_set
  end
end
