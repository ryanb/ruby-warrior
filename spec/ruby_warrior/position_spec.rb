require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Position do
  before(:each) do
    @floor = RubyWarrior::Floor.new(3, 5)
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
end
