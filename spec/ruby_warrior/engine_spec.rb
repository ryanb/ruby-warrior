require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Engine do
  before(:each) do
    @engine = RubyWarrior::Engine.new
  end
  
  it "should call turn on all objects" do
    object = stub(:object)
    object.expects(:turn)
    @engine.objects << object
    @engine.play(1)
  end
  
  it "should call turn number of times passed" do
    object = stub(:object)
    object.expects(:turn).times(2)
    @engine.objects << object
    @engine.play(2)
  end
  
  it "should assign object to ability and execute it" do
    object = stub(:object)
    ability = RubyWarrior::Ability.new
    ability.expects(:act)
    object.stubs(:turn).returns(ability)
    @engine.objects << object
    @engine.play(1)
    ability.owner.should == object
  end
end
