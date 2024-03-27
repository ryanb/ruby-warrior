require "spec_helper"

describe RubyWarrior::Space do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
  end

  describe "with empty space" do
    before(:each) { @space = @floor.space(0, 0) }

    it "should not be enemy" do
      expect(@space).to_not be_enemy
    end

    it "should not be warrior" do
      expect(@space).to_not be_warrior
    end

    it "should be empty" do
      expect(@space).to be_empty
    end

    it "should not be wall" do
      expect(@space).to_not be_wall
    end

    it "should not be stairs" do
      expect(@space).to_not be_stairs
    end

    it "should not be captive" do
      expect(@space).to_not be_captive
    end

    it "should say 'nothing' as name" do
      expect(@space.to_s).to eq("nothing")
    end

    it "should not be ticking" do
      expect(@space).to_not be_ticking
    end
  end

  describe "out of bounds" do
    before(:each) { @space = @floor.space(-1, 1) }

    it "should be wall" do
      expect(@space).to be_wall
    end

    it "should not be empty" do
      expect(@space).to_not be_empty
    end

    it "should have name of 'wall'" do
      expect(@space.to_s).to eq("wall")
    end
  end

  describe "with warrior" do
    before(:each) do
      warrior = RubyWarrior::Units::Warrior.new
      @floor.add(warrior, 0, 0)
      @space = @floor.space(0, 0)
    end

    it "should be warrior" do
      expect(@space).to be_warrior
    end

    it "should be player" do
      expect(@space).to be_warrior
    end

    it "should not be enemy" do
      expect(@space).to_not be_enemy
    end

    it "should not be empty" do
      expect(@space).to_not be_enemy
    end

    it "should know what unit is on that space" do
      expect(@space.unit).to be_kind_of(RubyWarrior::Units::Warrior)
    end
  end

  describe "with enemy" do
    before(:each) do
      @floor.add(RubyWarrior::Units::Sludge.new, 0, 0)
      @space = @floor.space(0, 0)
    end

    it "should be enemy" do
      expect(@space).to be_enemy
    end

    it "should not be warrior" do
      expect(@space).to_not be_warrior
    end

    it "should not be empty" do
      expect(@space).to_not be_empty
    end

    it "should have name of unit" do
      expect(@space.to_s).to eq("Sludge")
    end

    describe "bound" do
      before(:each) { @space.unit.bind }

      it "should be captive" do
        expect(@space).to be_captive
      end

      it "should not look like enemy" do
        expect(@space).to_not be_enemy
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
      expect(@space).to be_captive
    end

    it "should not be enemy" do
      expect(@space).to_not be_enemy
    end

    it "should be ticking if captive has time bomb" do
      @captive.add_abilities :explode!
      expect(@space).to be_ticking
    end

    it "should not be ticking if captive does not have time bomb" do
      expect(@space).to_not be_ticking
    end
  end

  describe "with golem" do
    before(:each) do
      @golem = RubyWarrior::Units::Golem.new
      @floor.add(@golem, 0, 0)
      @space = @floor.space(0, 0)
    end

    it "should be golem" do
      expect(@space).to be_golem
    end

    it "should not be enemy" do
      expect(@space).to_not be_enemy
    end

    it "should be player" do
      expect(@space).to be_player
    end
  end

  describe "at stairs" do
    before(:each) do
      @floor.place_stairs(0, 0)
      @space = @floor.space(0, 0)
    end

    it "should be empty" do
      expect(@space).to be_empty
    end

    it "should be stairs" do
      expect(@space).to be_stairs
    end
  end
end
