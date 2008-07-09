require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Turn do
  describe "with a couple actions" do
    before(:each) do
      @turn = RubyWarrior::Turn.new([:walk, :attack], [])
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
end
