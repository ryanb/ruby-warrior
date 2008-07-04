require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Position do
  before(:each) do
    @floor = RubyWarrior::Floor.new(6, 5)
    @position = RubyWarrior::Position.new(@floor, 1, 2, :north)
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
  
  it "should get relative object in front" do
    obj = Object.new
    @floor.set(obj, 1, 1)
    @position.get_relative(1).should == obj
  end
  
  it "should get relative object in front when rotated" do
    obj = Object.new
    @floor.set(obj, 2, 2)
    @position.rotate(1)
    @position.get_relative(1).should == obj
  end
  
  it "should get relative object diagonally" do
    obj = Object.new
    @floor.set(obj, 0, 1)
    @position.get_relative(1, -1).should == obj
  end
  
  it "should get relative object diagonally when rotating" do
    obj = Object.new
    @floor.set(obj, 0, 1)
    @position.rotate(2)
    @position.get_relative(-1, 1).should == obj
  end
  
  it "should move object on floor relatively" do
    obj = Object.new
    @floor.set(obj, 1, 2)
    @position.move(-1, 2)
    @floor.get(1, 2).should be_nil
    @floor.get(3, 3).should == obj
    @position.rotate(1)
    @position.move(-1)
    @floor.get(3, 3).should be_nil
    @floor.get(2, 3).should == obj
  end
end
