require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Level do
  before(:each) do
    @level = RubyWarrior::Level.new(RubyWarrior::Profile.new, 1)
    @level.stubs(:failed?).returns(false)
  end
  
  it "should be able to set size" do
    @level.set_size 5, 3
    @level.width.should == 5
    @level.height.should == 3
  end
  
  it "should call prepare_turn and play_turn on each object specified number of times" do
    object = RubyWarrior::Units::Base.new
    object.expects(:prepare_turn).times(2)
    object.expects(:perform_turn).times(2)
    @level.add(object, 0, 0, :north)
    @level.play(2)
  end
  
  it "should return immediately when passed" do
    object = RubyWarrior::Units::Base.new
    object.expects(:turn).times(0)
    @level.add(object, 0, 0, :north)
    @level.stubs(:passed?).returns(true)
    @level.play(2)
  end
  
  it "should consider passed when warrior is on stairs" do
    @level.warrior = RubyWarrior::Units::Warrior.new(RubyWarrior::Profile.new)
    @level.add(@level.warrior, 0, 0, :north)
    @level.place_stairs(0, 0)
    @level.should be_passed
  end
  
  it "should yield to block in play method for each turn" do
    int = 0
    @level.play(2) do
      int += 1
    end
    int.should == 2
  end
  
  it "should load file contents into level" do
    File.expects(:read).with('path/to/level.rb').returns("size 2, 8")
    @level.load_level('path/to/level.rb')
    @level.width.should == 2
    @level.height.should == 8
  end
end
