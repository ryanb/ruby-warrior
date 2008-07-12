require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Game do
  before(:each) do
    @game = RubyWarrior::Game.new
  end
  
  it "should include tower name in player path" do
    @game.stubs(:tower_name).returns('foo')
    @game.player_path.should == 'ruby-warrior/foo-tower'
  end
  
  
  # GAME DIR
  
  it "should make game directory if player says so" do
    RubyWarrior::UI.stubs(:request_boolean).returns(true)
    Dir.expects(:mkdir).with('ruby-warrior')
    @game.make_game_directory
  end
  
  it "should not make game and exit if player says no" do
    RubyWarrior::UI.stubs(:request_boolean).returns(false)
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
    Dir.expects(:[]).with("ruby-warrior/**/.profile")
    @game.profile_paths
  end
  
  it "should try to create profile when no profile paths are specified" do
    @game.stubs(:profiles).returns([])
    @game.expects(:new_profile).returns('profile')
    @game.profile.should == 'profile'
  end
  
  it "should ask a player to choose a profile if multiple profiles are available" do
    RubyWarrior::UI.expects(:choose).with([:profile1, [:new, 'New Profile']]).returns(:profile1)
    @game.stubs(:profiles).returns([:profile1])
    @game.profile.should == :profile1
  end
  
  it "should make a new profile if player chooses" do
    RubyWarrior::UI.expects(:choose).returns(:new)
    @game.stubs(:profiles).returns([:profile1])
    @game.expects(:new_profile).returns('new_profile')
    @game.profile.should == 'new_profile'
  end
  
  it "should ask user to choose a tower when creating a new profile" do
    @game.stubs(:towers).returns([:tower1, :tower2])
    RubyWarrior::UI.expects(:choose).with([:tower1, :tower2]).returns(stub(:path => '/foo/bar'))
    @game.new_profile
  end
  
  it "should pass name and selected tower to profile" do
    RubyWarrior::UI.stubs(:choose).returns(stub(:path => 'tower_path'))
    RubyWarrior::UI.stubs(:request).returns('name')
    RubyWarrior::Profile.expects(:new).with('tower_path', 'name').returns('profile')
    @game.new_profile.should == 'profile'
  end
  
  
  # TOWERS
  
  it "load towers for each tower path" do
    RubyWarrior::Tower.expects(:load).with('towers/foo').returns(1)
    RubyWarrior::Tower.expects(:load).with('towers/bar').returns(2)
    @game.stubs(:tower_paths).returns(['towers/foo', 'towers/bar'])
    @game.towers.should == [1, 2]
  end
  
  it "should find tower paths using Dir[] search" do
    Dir.expects(:[]).with(File.expand_path(File.dirname(__FILE__) + '/../../towers/*'))
    @game.tower_paths
  end
  
end
