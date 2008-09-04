require File.dirname(__FILE__) + '/../../spec_helper'

class Player
  def turn(warrior)
  end
end

describe RubyWarrior::Units::Warrior do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
  end
  
  it "should default name to warrior" do
    @warrior.name.should == "Warrior"
    @warrior.name = ''
    @warrior.name.should == "Warrior"
  end
  
  it "should be able to set name" do
    @warrior.name = "Joe"
    @warrior.name.should == "Joe"
    @warrior.to_s.should == "Joe"
  end
  
  it "should have 20 max health" do
    @warrior.max_health.should == 20
  end
  
  it "should have 0 score at beginning and be able to earn points" do
    @warrior.score.should be_zero
    @warrior.earn_points(5)
    @warrior.score.should == 5
  end
  
  it "should call player.play_turn and pass turn to player" do
    player = stub
    player.expects(:play_turn).with('turn')
    @warrior.stubs(:player).returns(player)
    @warrior.play_turn('turn')
  end
  
  it "should call Player.new the first time loading player, and return same object next time" do
    Player.expects(:new).returns('player').times(1)
    2.times do
      @warrior.player.should == 'player'
    end
  end
  
  it "should have an attack power of 5" do
    @warrior.attack_power.should == 5
  end
  
  it "should appear as W on map" do
    @warrior.to_map.should == "W"
  end
end
