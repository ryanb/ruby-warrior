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
    @position.direction.should == :north
    [:east, :south, :west, :north, :east].each do |dir|
      @position.rotate(1)
      @position.direction.should == dir
    end
  end
  
  it "should rotate counterclockwise" do
    @position.direction.should == :north
    [:west, :south, :east, :north, :west].each do |dir|
      @position.rotate(-1)
      @position.direction.should == dir
    end
  end
  
  it "should get relative space in front" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 1, 1)
    @position.relative_space(1).should_not be_empty
  end
  
  it "should get relative object in front when rotated" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 2, 2)
    @position.rotate(1)
    @position.relative_space(1).should_not be_empty
  end
  
  it "should get relative object diagonally" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1)
    @position.relative_space(1, -1).should_not be_empty
  end
  
  it "should get relative object diagonally when rotating" do
    unit = RubyWarrior::Units::Base.new
    @floor.add(unit, 0, 1)
    @position.rotate(2)
    @position.relative_space(-1, 1).should_not be_empty
  end
  
  it "should move object on floor relatively" do
    @floor.get(1, 2).should == @unit
    @position.move(-1, 2)
    @floor.get(1, 2).should be_nil
    @floor.get(3, 3).should == @unit
    @position.rotate(1)
    @position.move(-1)
    @floor.get(3, 3).should be_nil
    @floor.get(2, 3).should == @unit
  end
  
  it "should return distance from stairs as 0 when on stairs" do
    @floor.place_stairs(1, 2)
    @position.distance_from_stairs.should == 0
  end
  
  it "should return distance from stairs in both directions" do
    @floor.place_stairs(0, 3)
    @position.distance_from_stairs.should == 2
  end
  
  it "should return relative direction of stairs" do
    @floor.place_stairs(0, 0)
    @position.relative_direction_of_stairs.should == :forward
  end
  
  it "should return relative direction of given space" do
    @position.relative_direction_of(@floor.space(5, 3)).should == :right
    @position.rotate 1
    @position.relative_direction_of(@floor.space(1, 4)).should == :right
  end
  
  it "should be able to determine relative direction" do
    @position.relative_direction(:north).should == :forward
    @position.relative_direction(:south).should == :backward
    @position.relative_direction(:west).should == :left
    @position.relative_direction(:east).should == :right
    @position.rotate 1
    @position.relative_direction(:north).should == :left
    @position.rotate 1
    @position.relative_direction(:north).should == :backward
    @position.rotate 1
    @position.relative_direction(:north).should == :right
  end
  
  it "should return a space at the same location as position" do
    @position.space.location.should == [1, 2]
  end
  
  it "should return distance of given space" do
    @position.distance_of(@floor.space(5, 3)).should == 5
    @position.distance_of(@floor.space(4, 2)).should == 3
  end
end
