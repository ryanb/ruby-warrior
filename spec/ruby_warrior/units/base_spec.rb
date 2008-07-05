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
  
  it "should be able to perform action twice if on separate turn" do
    @unit.position = stub_everything
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
  
  it "should subtract health when taking damage" do
    @unit.health = 10
    @unit.take_damage(3)
    @unit.health.should == 7
  end
  
  it "should do nothing when taking damage if health isn't set" do
    lambda { @unit.take_damage(3) }.should_not raise_error(Exception)
  end
  
  it "should set position to nil when running out of health" do
    @unit.position = stub
    @unit.health = 10
    @unit.take_damage(10)
    @unit.position.should be_nil
  end
  
  it "should not call turn if position isn't set" do
    @unit.position = nil
    @unit.stubs(:turn).raises('should not be called')
    lambda { @unit.perform_turn }.should_not raise_error(Exception)
  end
  
  it "should print out line with name when speaking" do
    RubyWarrior::UI.expects(:puts).with("Base foo")
    @unit.say "foo"
  end
  
  it "should return name in to_s" do
    @unit.name.should == 'Base'
    @unit.to_s.should == 'Base'
  end
end
