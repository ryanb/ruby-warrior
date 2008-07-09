require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Turn do
  describe "with actions" do
    before(:each) do
      @turn = RubyWarrior::Turn.new([:walk, :attack], {})
    end
    
    it "should have no action performed at first" do
      @turn.action.should be_nil
    end
    
    it "should be able to perform action and recall it" do
      @turn.walk!
      @turn.action.should == [:walk]
    end
    
    it "should include arguments passed to action" do
      @turn.walk! :forward
      @turn.action.should == [:walk, :forward]
    end
    
    it "should not be able to call multiple actions per turn" do
      @turn.walk! :forward
      lambda { @turn.attack! }.should raise_error(Exception)
    end
  end
  
  describe "with senses" do
    before(:each) do
      @feel = RubyWarrior::Abilities::Feel.new(Object.new)
      @feel.stubs(:space).returns(Object.new)
      @feel.stubs(:space).with(:back).returns(Object.new)
      @turn = RubyWarrior::Turn.new([], {:feel => @feel})
    end
    
    it "should be able to call sense with any argument and return expected results" do
      @turn.feel.should == @feel.perform
      @turn.feel(:back).should == @feel.perform(:back)
    end
    
    it "should have memorized result" do
      result = @feel.perform(:back)
      @feel.stubs(:space).with(:back).returns(nil)
      @turn.feel(:back).should == result
    end
    
    it "should have memorized result" do
      result = @feel.perform(:back)
      @feel.stubs(:space).with(:back).returns(nil)
      @turn.feel(:back).should == result
    end
    
    it "should raise an exception for unexpected argument" do
      lambda { @turn.feel(:bad) }.should raise_error(Exception)
    end
  end
end
