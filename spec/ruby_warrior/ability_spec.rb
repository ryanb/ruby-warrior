require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Ability do
  before(:each) do
    @ability = RubyWarrior::Ability.new
  end
  
  it "should have act method which raises an exception" do
    lambda { @ability.act }.should raise_error(Exception)
  end
  
  it "should assign an owner" do
    object = Object.new
    @ability.owner = object
    @ability.owner.should == object
  end
end
