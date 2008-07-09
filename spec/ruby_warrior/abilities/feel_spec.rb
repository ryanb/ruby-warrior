require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Feel do
  before(:each) do
    @unit = stub(:position => stub, :say => nil)
    @feel = RubyWarrior::Abilities::Feel.new(@unit)
  end
  
  it "should get object at position from offset" do
    @unit.position.expects(:relative_space).with(1, 0)
    @feel.perform(:forward)
  end
  
  it "should have all directions as possible arguments" do
    [[], :forward, :back, :left, :right].each do |arg|
      @feel.possible_arguments.should include(arg)
    end
  end
end
