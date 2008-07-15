require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Space do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
  end
  
  describe "with empty space" do
    before(:each) do
      @space = @floor.space(0, 0)
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should not be warrior" do
      @space.should_not be_warrior
    end
    
    it "should be empty" do
      @space.should be_empty
    end
    
    it "should not be wall" do
      @space.should_not be_wall
    end
    
    it "should not be stairs" do
      @space.should_not be_stairs
    end
  end
  
  describe "out of bounds" do
    before(:each) do
      @space = @floor.space(-1, 1)
    end
  
    it "should be wall" do
      @space.should be_wall
    end
  
    it "should not be empty" do
      @space.should_not be_empty
    end
  end
  
  describe "with warrior" do
    before(:each) do
      warrior = RubyWarrior::Units::Warrior.new
      @floor.add(warrior, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be warrior" do
      @space.should be_warrior
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should not be empty" do
      @space.should_not be_enemy
    end
    
    it "should know what unit is on that space" do
      @space.unit.should be_kind_of(RubyWarrior::Units::Warrior)
    end
  end
  
  describe "with enemy" do
    before(:each) do
      @floor.add(RubyWarrior::Units::Sludge.new, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be enemy" do
      @space.should be_enemy
    end
    
    it "should not be warrior" do
      @space.should_not be_warrior
    end
    
    it "should not be empty" do
      @space.should_not be_empty
    end
  end
  
  describe "at stairs" do
    before(:each) do
      @floor.place_stairs(0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be empty" do
      @space.should be_empty
    end
    
    it "should be stairs" do
      @space.should be_stairs
    end
  end
end
