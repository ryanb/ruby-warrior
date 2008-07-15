require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Level do
  before(:each) do
    @profile = RubyWarrior::Profile.new
    @floor = RubyWarrior::Floor.new
    @level = RubyWarrior::Level.new(@profile, 1)
    @level.floor = @floor
    @level.stubs(:failed?).returns(false)
  end
  
  it "should call prepare_turn and play_turn on each object specified number of times" do
    @level.expects(:load_level)
    object = RubyWarrior::Units::Base.new
    object.expects(:prepare_turn).times(2)
    object.expects(:perform_turn).times(2)
    @floor.add(object, 0, 0, :north)
    @level.play(2)
  end
  
  it "should return immediately when passed" do
    @level.expects(:load_level)
    object = RubyWarrior::Units::Base.new
    object.expects(:turn).times(0)
    @floor.add(object, 0, 0, :north)
    @level.stubs(:passed?).returns(true)
    @level.play(2)
  end
  
  it "should consider passed when warrior is on stairs" do
    @level.warrior = RubyWarrior::Units::Warrior.new
    @floor.add(@level.warrior, 0, 0, :north)
    @floor.place_stairs(0, 0)
    @level.should be_passed
  end
  
  it "should yield to block in play method for each turn" do
    @level.expects(:load_level)
    int = 0
    @level.play(2) do
      int += 1
    end
    int.should == 2
  end
  
  it "should load file contents into level" do
    @level.stubs(:load_path).returns('path/to/level.rb')
    File.expects(:read).with('path/to/level.rb').returns("description 'foo'")
    @level.load_level
    @level.description.should == 'foo'
  end
  
  it "should have a player path from profile with level number in it" do
    @profile.stubs(:player_path).returns('path/to/player')
    @level.player_path.should == 'path/to/player/level-001'
  end
  
  it "should have a load path from profile tower with level number in it" do
    @profile.stubs(:tower_path).returns('path/to/tower')
    @level.load_path.should == 'path/to/tower/level_001.rb'
  end
  
  it "should exist if file exists" do
    @level.stubs(:load_path).returns('/foo/bar')
    File.expects(:exist?).with('/foo/bar').returns(true)
    @level.exists?.should be_true
  end
  
  it "should load player and player path" do
    @level.stubs(:player_path).returns('player/path')
    $:.expects(:<<).with('player/path')
    @level.expects(:load).with('player.rb')
    @level.load_player
  end
  
  it "should generate player files" do
    @level.expects(:load_level)
    generator = stub
    generator.expects(:generate)
    RubyWarrior::PlayerGenerator.expects(:new).with(@level).returns(generator)
    @level.generate_player_files
  end
  
  it "should setup warrior with profile abilities" do
    @profile.abilities = [:foo, :bar]
    warrior = stub
    warrior.expects(:add_abilities).with(:foo, :bar)
    @level.setup_warrior(warrior)
  end
  
  describe "tallying points" do
    before(:each) do
      @warrior = stub(:score => 0, :abilities => {})
      @level.stubs(:warrior).returns(@warrior)
    end
    
    it "should add warrior score to profile" do
      @warrior.stubs(:score).returns(30)
      @level.tally_points
      @profile.score.should == 30
    end
    
    it "should apply warrior abilities to profile" do
      @warrior.stubs(:abilities).returns({:foo => nil, :bar => nil})
      @level.tally_points
      @profile.abilities.should == [:foo, :bar]
    end
  end
end
