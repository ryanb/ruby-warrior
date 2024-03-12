require 'spec_helper'

describe RubyWarrior::Game do
  before(:each) do
    @game = RubyWarrior::Game.new
  end

  # GAME DIR

  it "should make game directory if player says so" do
    allow(RubyWarrior::UI).to receive(:ask).and_return(true)
    expect(Dir).to receive(:mkdir).with('./rubywarrior')
    @game.make_game_directory
  end

  it "should not make game and exit if player says no" do
    allow(RubyWarrior::UI).to receive(:ask).and_return(false)
    allow(Dir).to receive(:mkdir).and_raise('should not be called')
    expect { @game.make_game_directory }.to raise_error(SystemExit)
  end


  # PROFILES

  it "should load profiles for each profile path" do
    expect(RubyWarrior::Profile).to receive(:load).with('foo/.profile').and_return(1)
    expect(RubyWarrior::Profile).to receive(:load).with('bar/.profile').and_return(2)
    allow(@game).to receive(:profile_paths).and_return(['foo/.profile', 'bar/.profile'])
    expect(@game.profiles).to eq([1, 2])
  end

  it "should find profile paths using Dir[] search" do
    expect(Dir).to receive(:[]).with("./rubywarrior/**/.profile")
    @game.profile_paths
  end

  it "should try to create profile when no profile paths are specified" do
    allow(@game).to receive(:profiles).and_return([])
    expect(@game).to receive(:new_profile).and_return('profile')
    expect(@game.profile).to eq('profile')
  end

  it "should ask a player to choose a profile if multiple profiles are available, but only once" do
    expect(RubyWarrior::UI).to receive(:choose).with('profile', [:profile1, [:new, 'New Profile']]).and_return(:profile1)
    allow(@game).to receive(:profiles).and_return([:profile1])
    2.times { expect(@game.profile).to eq(:profile1) }
  end

  it "should ask user to choose a tower when creating a new profile" do
    allow(RubyWarrior::UI).to receive(:gets).and_return('')
    allow(@game).to receive(:towers).and_return([:tower1, :tower2])
    expect(RubyWarrior::UI).to receive(:choose).with('tower', [:tower1, :tower2]).and_return(double(path: '/foo/bar'))
    @game.new_profile
  end

  it "should pass name and selected tower to profile" do
    profile = double
    allow(RubyWarrior::UI).to receive(:choose).and_return(double(path: 'tower_path'))
    allow(RubyWarrior::UI).to receive(:request).and_return('name')
    expect(RubyWarrior::Profile).to receive(:new).and_return(profile)
    expect(profile).to receive(:tower_path=).with('tower_path')
    expect(profile).to receive(:warrior_name=).with('name')
    expect(@game.new_profile).to eq(profile)
  end


  # TOWERS

  it "load towers for each tower path" do
    expect(RubyWarrior::Tower).to receive(:new).with('towers/foo').and_return(1)
    expect(RubyWarrior::Tower).to receive(:new).with('towers/bar').and_return(2)
    allow(@game).to receive(:tower_paths).and_return(['towers/foo', 'towers/bar'])
    expect(@game.towers).to eq([1, 2])
  end

  it "should find tower paths using Dir[] search" do
    expect(Dir).to receive(:[]).with(File.expand_path('../../../towers/*', __FILE__))
    @game.tower_paths
  end


  # LEVEL

  it "should fetch current level from profile and cache it" do
    allow(@game).to receive(:profile).and_return(double)
    expect(@game.profile).to receive(:current_level).and_return('foo')
    2.times { expect(@game.current_level).to eq('foo') }
  end

  it "should fetch next level from profile and cache it" do
    allow(@game).to receive(:profile).and_return(double)
    expect(@game.profile).to receive(:next_level).and_return('bar')
    2.times { expect(@game.next_level).to eq('bar') }
  end

  it "should report final grade" do
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    allow(@game).to receive(:profile).and_return(profile)
    report = @game.final_report
    expect(report).to include("Your average grade for this tower is: B")
    expect(report).to include("Level 1: C\n  Level 2: A")
  end

  it "should have an empty final report if no epic grades are available" do
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = {}
    allow(@game).to receive(:profile).and_return(profile)
    expect(@game.final_report).to be_nil
  end

  it "should have an empty final report if practice level" do
    RubyWarrior::Config.practice_level = 2
    profile = RubyWarrior::Profile.new
    profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    allow(@game).to receive(:profile).and_return(profile)
    expect(@game.final_report).to be_nil
  end
end
