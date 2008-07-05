require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Floor do
  before(:each) do
    @floor = RubyWarrior::Floor.new(2, 3)
  end
  
  it "should accept rows and cols size as grid size" do
    @floor.grid.size.should == 2
    @floor.grid.first.size.should == 3
    @floor.width.should == 2
    @floor.height.should == 3
  end
  
  it "should get nil in 0, 0 position" do
    @floor.get(0, 0).should be_nil
  end
  
  it "should set object at position and get it" do
    obj = Object.new
    @floor.set(obj, 0, 0)
    @floor.get(0, 0).should == obj
  end
  
  it "should clear position and reset to nil" do
    obj = Object.new
    @floor.set(obj, 0, 0)
    @floor.clear(0, 0).should == obj
    @floor.get(0, 0).should be_nil
  end
  
  it "should return all objects" do
    a = Object.new
    b = Object.new
    @floor.set(a, 0, 0)
    @floor.set(b, 0, 1)
    @floor.objects.should == [a, b]
  end
end
