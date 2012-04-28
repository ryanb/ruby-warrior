require_relative '../spec_helper'

describe RubyWarrior::Turn do
  describe "with actions" do
    before(:each) do
      @turn = RubyWarrior::Turn.new({:walk! => nil, :attack! => nil})
    end
    
    it "should have no action performed at first" do
      @turn.action.should be_nil
    end
    
    it "should be able to perform action and recall it" do
      @turn.walk!
      @turn.action.should == [:walk!]
    end
    
    it "should include arguments passed to action" do
      @turn.walk! :forward
      @turn.action.should == [:walk!, :forward]
    end
    
    it "should not be able to call multiple actions per turn" do
      @turn.walk! :forward
      lambda { @turn.attack! }.should raise_error
    end
  end
  
  describe "with senses" do
    before(:each) do
      @feel = RubyWarrior::Abilities::Feel.new(Object.new)
      @feel.stubs(:space).returns(Object.new)
      @feel.stubs(:space).with(:backward).returns(Object.new)
      @turn = RubyWarrior::Turn.new({:feel => @feel})
    end
    
    it "should be able to call sense with any argument and return expected results" do
      @turn.feel.should == @feel.perform
      @turn.feel(:backward).should == @feel.perform(:backward)
    end
  end
end
