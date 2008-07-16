require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::LevelLoader do
  describe "with profile" do
    before(:each) do
      @profile = RubyWarrior::Profile.new
      @level = RubyWarrior::Level.new(@profile, 1)
      @loader = RubyWarrior::LevelLoader.new(@level)
    end
    
    it "should be able to add description and tip" do
      @loader.description "foo"
      @loader.tip "bar"
      @level.description.should == "foo"
      @level.tip.should == "bar"
    end
    
    it "should be able to set size" do
      @loader.size 5, 3
      @level.floor.width.should == 5
      @level.floor.height.should == 3
    end
    
    it "should be able to add stairs" do
      @level.floor.expects(:place_stairs).with(1, 2)
      @loader.stairs 1, 2
    end
    
    it "should yield new unit when building" do
      @loader.unit :base, 1, 2 do |unit|
        unit.should be_kind_of(RubyWarrior::Units::Base)
        unit.position.should be_at(1, 2)
      end
    end
    
    it "should be able to add multi-word units" do
      lambda { @loader.unit :thick_sludge, 1, 2 }.should_not raise_error
    end
    
    it "should build warrior from profile" do
      @loader.warrior 1, 2 do |unit|
        unit.should be_kind_of(RubyWarrior::Units::Warrior)
        unit.position.should be_at(1, 2)
      end
    end
    
    it "should be able to set time bonus" do
      @loader.time_bonus 100
      @level.time_bonus.should == 100
    end
  end
end
