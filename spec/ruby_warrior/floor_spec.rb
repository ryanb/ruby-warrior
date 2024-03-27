require "spec_helper"

describe RubyWarrior::Floor do
  describe "2x3" do
    before(:each) do
      @floor = RubyWarrior::Floor.new
      @floor.width = 2
      @floor.height = 3
    end

    it "should be able to add a unit and fetch it at that position" do
      unit = RubyWarrior::Units::Base.new
      @floor.add(unit, 0, 1, :north)
      expect(@floor.get(0, 1)).to eq(unit)
    end

    it "should not consider unit on floor if no position" do
      unit = RubyWarrior::Units::Base.new
      @floor.add(unit, 0, 1, :north)
      unit.position = nil
      expect(@floor.units).to_not include(unit)
    end

    it "should fetch other units not warrior" do
      unit = RubyWarrior::Units::Base.new
      warrior = RubyWarrior::Units::Warrior.new
      @floor.add(unit, 0, 0, :north)
      @floor.add(warrior, 1, 0, :north)
      expect(@floor.other_units).to_not include(warrior)
      expect(@floor.other_units).to include(unit)
    end

    it "should not consider corners out of bounds" do
      expect(@floor).to_not be_out_of_bounds(0, 0)
      expect(@floor).to_not be_out_of_bounds(1, 0)
      expect(@floor).to_not be_out_of_bounds(1, 2)
      expect(@floor).to_not be_out_of_bounds(0, 2)
    end

    it "should consider out of bounds when going beyond sides" do
      expect(@floor).to be_out_of_bounds(-1, 0)
      expect(@floor).to be_out_of_bounds(0, -1)
      expect(@floor).to be_out_of_bounds(0, 3)
      expect(@floor).to be_out_of_bounds(2, 0)
    end

    it "should return space at the specified location" do
      expect(@floor.space(0, 0)).to be_kind_of(RubyWarrior::Space)
    end

    it "should place stairs and be able to fetch the location" do
      @floor.place_stairs(1, 2)
      expect(@floor.stairs_location).to eq([1, 2])
    end
  end

  describe "3x1" do
    before(:each) do
      @floor = RubyWarrior::Floor.new
      @floor.width = 3
      @floor.height = 1
    end

    it "should print map with stairs and unit" do
      @floor.add(RubyWarrior::Units::Warrior.new, 0, 0)
      @floor.place_stairs(2, 0)
      expect(@floor.character).to eq(<<-MAP)
 ---
|@ >|
 ---
MAP
    end

    it "should return unique units" do
      u1 = RubyWarrior::Units::Base.new
      @floor.add(u1, 0, 0)
      @floor.add(RubyWarrior::Units::Base.new, 1, 0)
      expect(@floor.unique_units).to eq([u1])
    end
  end
end
