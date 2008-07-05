require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Base do
  before(:each) do
    @unit = RubyWarrior::Units::Base.new
  end
  
  it "should have a health attribute that defaults to nil" do
    @unit.health.should be_nil
  end
  
  it "should have a position attribute that defaults to nil" do
    @unit.position.should be_nil
  end
  
  it "should have an attack power which defaults to zero" do
    @unit.attack_power.should be_zero
  end
  
  it "should not have walk ability initially" do
    @unit.should_not respond_to(:walk!)
  end
  
  it "should have walk ability once added" do
    @unit.add_actions(:walk)
    walk = stub
    RubyWarrior::Abilities::Walk.expects(:new).with(@unit).returns(walk)
    walk.expects(:perform).with(:forward)
    @unit.walk! :forward
  end
  
  it "should be able to add multiple actions" do
    @unit.add_actions(:walk, :wait)
    @unit.should respond_to(:walk!)
    @unit.should respond_to(:wait!)
  end
  
  it "should not be able to call more than one action" do
    @unit.add_actions(:walk)
    @unit.walk!
    lambda { @unit.walk! }.should raise_error(Exception)
  end
  
  it "should be able to action twice if on separate turn" do
    @unit.add_actions(:walk)
    @unit.walk!
    @unit.perform_turn
    lambda { @unit.walk! }.should_not raise_error(Exception)
  end
  
  it "should have feel ability once added" do
    @unit.add_senses(:feel)
    feel = stub
    RubyWarrior::Abilities::Feel.expects(:new).with(@unit).returns(feel)
    feel.expects(:perform).with(:forward)
    @unit.feel :forward
  end
end
