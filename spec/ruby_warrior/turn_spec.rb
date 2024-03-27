require 'spec_helper'

describe RubyWarrior::Turn do
  describe "with actions" do
    before(:each) do
      @turn = RubyWarrior::Turn.new({:walk! => nil, :attack! => nil})
    end

    it "should have no action performed at first" do
      expect(@turn.action).to be_nil
    end

    it "should be able to perform action and recall it" do
      @turn.walk!
      expect(@turn.action).to eq([:walk!])
    end

    it "should include arguments passed to action" do
      @turn.walk! :forward
      expect(@turn.action).to eq([:walk!, :forward])
    end

    it "should not be able to call multiple actions per turn" do
      @turn.walk! :forward
      expect { @turn.attack! }.to raise_error("Only one action can be performed per turn.")
    end
  end

  describe "with senses" do
    before(:each) do
      @feel = RubyWarrior::Abilities::Feel.new(Object.new)
      allow(@feel).to receive(:space).and_return(Object.new)
      allow(@feel).to receive(:space).with(:backward).and_return(Object.new)
      @turn = RubyWarrior::Turn.new({:feel => @feel})
    end

    it "should be able to call sense with any argument and return expected results" do
      expect(@turn.feel).to eq(@feel.perform)
      expect(@turn.feel(:backward)).to eq(@feel.perform(:backward))
    end
  end
end
