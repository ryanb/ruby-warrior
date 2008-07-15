require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::LevelBuilder do
  describe "with profile" do
    before(:each) do
      @profile = RubyWarrior::Profile.new
      @level = RubyWarrior::Level.new(@profile, 1)
      @builder = RubyWarrior::LevelBuilder.new(@level)
    end
  
    it "should be able to add description and tip" do
      @builder.description "foo"
      @builder.tip "bar"
      @level.description.should == "foo"
      @level.tip.should == "bar"
    end
  
    it "should be able to add stairs" do
      @level.expects(:place_stairs).with(1, 2)
      @builder.stairs 1, 2
    end
    
    it "should yield new unit when building" do
      @builder.unit :base, 1, 2 do |unit|
        unit.should be_kind_of(RubyWarrior::Units::Base)
        unit.position.should be_at(1, 2)
      end
    end
    
    it "should build warrior from profile" do
      @builder.warrior 1, 2 do |unit|
        unit.should be_kind_of(RubyWarrior::Units::Warrior)
        unit.position.should be_at(1, 2)
      end
    end
  end
end
