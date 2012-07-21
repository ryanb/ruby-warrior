require 'spec_helper'

describe RubyWarrior::Game do
  before(:each) do
    @game = RubyWarrior::Game.new
  end
  
  # GAME DIR

  it "should make base directory if player says so" do
    RubyWarrior::UI.stubs(:ask).returns(true)
    Dir.expects(:mkdir).with(RubyWarrior::Config.path_prefix)
    @game.make_game_directory
  end
  
  it "should make game directory if player says so" do
    RubyWarrior::UI.stubs(:ask).returns(true)
    Dir.expects(:mkdir).with('./rubywarrior')
    @game.make_game_directory('rubywarrior')
  end
  
  it "should not make game and exit if player says no" do
    RubyWarrior::UI.stubs(:ask).returns(false)
    Dir.stubs(:mkdir).raises('should not be called')
    lambda { @game.make_game_directory }.should raise_error(SystemExit)
  end
  
  
  # PROFILES
  
  it "should load profiles for each profile path" do
    RubyWarrior::Profile.expects(:load).with('foo/.profile').returns(1)
    RubyWarrior::Profile.expects(:load).with('bar/.profile').returns(2)
    @game.stubs(:profile_paths).returns(['foo/.profile', 'bar/.profile'])
    @game.profiles.should == [1, 2]
  end
  
  it "should find profile paths using Dir[] search" do
    Dir.expects(:[]).with("./rubywarrior/**/.profile")
    @game.profile_paths
  end
  
  it "should try to create profile when no profile paths are specified" do
    @game.stubs(:profiles).returns([])
    @game.expects(:new_profile).returns('profile')
    @game.profile.should == 'profile'
  end
  
  it "should ask a player to choose a profile if multiple profiles are available, but only once" do
    RubyWarrior::UI.expects(:choose).with('profile', [:profile1, [:new, 'New Profile']]).returns(:profile1)
    @game.stubs(:profiles).returns([:profile1])
    2.times { @game.profile.should == :profile1 }
  end
  
  it "should ask user to choose a tower when creating a new profile" do
    RubyWarrior::UI.stubs(:gets).returns('')
    @game.stubs(:towers).returns([:tower1, :tower2])
    RubyWarrior::UI.expects(:choose).with('tower', [:tower1, :tower2]).returns(stub(:path => '/foo/bar'))
    @game.new_profile
  end
  
  it "should pass name and selected tower to profile" do
    profile = stub
    RubyWarrior::UI.stubs(:choose).returns(stub(:path => 'tower_path'))
    RubyWarrior::UI.stubs(:request).returns('name')
    RubyWarrior::Profile.expects(:new).returns(profile)
    profile.expects(:tower_path=).with('tower_path')
    profile.expects(:warrior_name=).with('name')
    @game.new_profile.should == profile
  end
  
  
  # TOWERS
  
  it "load towers for each tower path" do
    RubyWarrior::Tower.expects(:new).with('towers/foo').returns(1)
    RubyWarrior::Tower.expects(:new).with('towers/bar').returns(2)
    @game.stubs(:tower_paths).returns(['towers/foo', 'towers/bar'])
    @game.towers.should == [1, 2]
  end
  
  it "should find tower paths using Dir[] search" do
    Dir.expects(:[]).with(File.expand_path('../../../towers/*', __FILE__))
    @game.tower_paths
  end
  
  
  # LEVEL
  
  it "should fetch current level from profile and cache it" do
    @game.stubs(:profile).returns(stub)
    @game.profile.expects(:current_level).returns('foo')
    2.times { @game.current_level.should == 'foo' }
  end
  
  it "should fetch next level from profile and cache it" do
    @game.stubs(:profile).returns(stub)
    @game.profile.expects(:next_level).returns('bar')
    2.times { @game.next_level.should == 'bar' }
  end
  
  it "should report final grade" do
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @game.stubs(:profile).returns(profile)
    report = @game.final_report
    report.should include("Your average grade for this tower is: B")
    report.should include("Level 1: C\n  Level 2: A")
  end
  
  it "should have an empty final report if no epic grades are available" do
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = {}
    @game.stubs(:profile).returns(profile)
    @game.final_report.should be_nil
  end
  
  it "should have an empty final report if practice level" do
    RubyWarrior::Config.practice_level = 2
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @game.stubs(:profile).returns(profile)
    @game.final_report.should be_nil
  end
end
