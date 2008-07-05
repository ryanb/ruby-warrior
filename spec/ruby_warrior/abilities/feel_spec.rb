require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Feel do
  before(:each) do
    @unit = stub(:position => stub)
    @feel = RubyWarrior::Abilities::Feel.new(@unit)
  end
  
  it "should get object at position from offset" do
    @unit.position.expects(:get_relative).with(1, 0)
    @feel.perform(:forward)
  end
end
