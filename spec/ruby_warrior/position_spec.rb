require 'spec_helper'

describe RubyWarrior::Position do
  before(:each) do
    @unit = RubyWarrior::Units::Base.new
    @floor = RubyWarrior::Floor.new
    @floor.width = 6
    @floor.height = 5
    @floor.add(@unit, 1, 2, :north)
    @position = @unit.position
  end
  
  it "should rotate clockwise" do
    expect(@position.direction).to eq(:north)
    [:east, :south, :west, :north, :east].each do |dir|
      @position.rotate(1)
      expect(@position.direction).to eq(dir)
    end
  end
  
  it "should rotate counterclockwise" do
    expect(@position.direction).to eq(:north)
    [:west, :south, :east, :north, :west].each do |dir|
      @position.rotate(-1)
      expect(@position.direction).to eq(dir)
    end
  end
  
  it "should get relative space in front" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 1, 1)
    expect(@position.relative_space(1)).not_to be_empty
  end
  
  it "should get relative object in front when rotated" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 2, 2)
    @position.rotate(1)
    expect(@position.relative_space(1)).not_to be_empty
  end
  
  it "should get relative object diagonally" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1)
    expect(@position.relative_space(1, -1)).not_to be_empty
  end
  
  it "should get relative object diagonally when rotating" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1)
    @position.rotate(2)
    expect(@position.relative_space(-1, 1)).not_to be_empty
  end
  
  it "should move object on floor relatively" do
    expect(@floor.get(1, 2)).to eq(@unit)
    @position.move(-1, 2)
    expect(@floor.get(1, 2)).to be_nil
    expect(@floor.get(3, 3)).to eq(@unit)
    @position.rotate(1)
    @position.move(-1)
    expect(@floor.get(3, 3)).to be_nil
    expect(@floor.get(2, 3)).to eq(@unit)
  end
  
  it "should return distance from stairs as 0 when on stairs" do
    @floor.place_stairs(1, 2)
    expect(@position.distance_from_stairs).to eq(0)
  end
  
  it "should return distance from stairs in both directions" do
    @floor.place_stairs(0, 3)
    expect(@position.distance_from_stairs).to eq(2)
  end
  
  it "should return relative direction of stairs" do
    @floor.place_stairs(0, 0)
    expect(@position.relative_direction_of_stairs).to eq(:forward)
  end
  
  it "should return relative direction of given space" do
    expect(@position.relative_direction_of(@floor.space(5, 3))).to eq(:right)
    @position.rotate 1
    expect(@position.relative_direction_of(@floor.space(1, 4))).to eq(:right)
  end
  
  it "should be able to determine relative direction" do
    expect(@position.relative_direction(:north)).to eq(:forward)
    expect(@position.relative_direction(:south)).to eq(:backward)
    expect(@position.relative_direction(:west)).to eq(:left)
    expect(@position.relative_direction(:east)).to eq(:right)
    @position.rotate 1
    expect(@position.relative_direction(:north)).to eq(:left)
    @position.rotate 1
    expect(@position.relative_direction(:north)).to eq(:backward)
    @position.rotate 1
    expect(@position.relative_direction(:north)).to eq(:right)
  end
  
  it "should return a space at the same location as position" do
    expect(@position.space.location).to eq([1, 2])
  end
  
  it "should return distance of given space" do
    expect(@position.distance_of(@floor.space(5, 3))).to eq(5)
    expect(@position.distance_of(@floor.space(4, 2))).to eq(3)
  end
end
