require 'spec_helper'

describe RubyWarrior::LevelLoader do
  describe "with profile" do
    before(:each) do
      @profile = RubyWarrior::Profile.new
      @level = RubyWarrior::Level.new(@profile, 1)
      @loader = RubyWarrior::LevelLoader.new(@level)
    end

    it "should be able to add description, tip and clue" do
      @loader.description "foo"
      @loader.tip "bar"
      @loader.clue "clue"
      expect(@level.description).to eq("foo")
      expect(@level.tip).to eq("bar")
      expect(@level.clue).to eq("clue")
    end

    it "should be able to set size" do
      @loader.size 5, 3
      expect(@level.floor.width).to eq(5)
      expect(@level.floor.height).to eq(3)
    end

    it "should be able to add stairs" do
      expect(@level.floor).to receive(:place_stairs).with(1, 2)
      @loader.stairs 1, 2
    end

    it "should yield new unit when building" do
      @loader.unit :base, 1, 2 do |unit|
        expect(unit).to be_kind_of(RubyWarrior::Units::Base)
        expect(unit.position).to be_at(1, 2)
      end
    end

    it "should be able to add multi-word units" do
      expect { @loader.unit :thick_sludge, 1, 2 }.to_not raise_error
    end

    it "should build warrior from profile" do
      @loader.warrior 1, 2 do |unit|
        expect(unit).to be_kind_of(RubyWarrior::Units::Warrior)
        expect(unit.position).to be_at(1, 2)
      end
    end

    it "should be able to set time bonus" do
      @loader.time_bonus 100
      expect(@level.time_bonus).to eq(100)
    end
  end
end
