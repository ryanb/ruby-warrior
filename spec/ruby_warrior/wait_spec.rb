require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Wait do
  before(:each) do
    @wait = RubyWarrior::Wait.new
  end
  
  it "should not raise an exception" do
    lambda { @wait.act }.should_not raise_error(Exception)
  end
  
  it "should be subclass of Ability" do
    @wait.should be_kind_of(RubyWarrior::Ability)
  end
end
