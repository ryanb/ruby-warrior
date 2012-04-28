require 'spec_helper'

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
    
    it "should not be captive" do
      @space.should_not be_captive
    end
    
    it "should say 'nothing' as name" do
      @space.to_s.should == 'nothing'
    end
    
    it "should not be ticking" do
      @space.should_not be_ticking
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
    
    it "should have name of 'wall'" do
      @space.to_s.should == 'wall'
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
    
    it "should be player" do
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
    
    it "should have name of unit" do
      @space.to_s.should == "Sludge"
    end
    
    describe "bound" do
      before(:each) do
        @space.unit.bind
      end
      
      it "should be captive" do
        @space.should be_captive
      end
      
      it "should not look like enemy" do
        @space.should_not be_enemy
      end
    end
  end
  
  describe "with captive" do
    before(:each) do
      @captive = RubyWarrior::Units::Captive.new
      @floor.add(@captive, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be captive" do
      @space.should be_captive
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should be ticking if captive has time bomb" do
      @captive.add_abilities :explode!
      @space.should be_ticking
    end
    
    it "should not be ticking if captive does not have time bomb" do
      @space.should_not be_ticking
    end
  end
  
  describe "with golem" do
    before(:each) do
      @golem = RubyWarrior::Units::Golem.new
      @floor.add(@golem, 0, 0)
      @space = @floor.space(0, 0)
    end
    
    it "should be golem" do
      @space.should be_golem
    end
    
    it "should not be enemy" do
      @space.should_not be_enemy
    end
    
    it "should be player" do
      @space.should be_player
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
