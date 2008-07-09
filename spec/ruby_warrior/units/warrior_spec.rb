require File.dirname(__FILE__) + '/../../spec_helper'

class Player
  def turn(warrior)
  end
end

describe RubyWarrior::Units::Warrior do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
  end
  
  it "should have a health attribute that defaults to 20" do
    @warrior.health.should == 20
    @warrior.health -= 5
    @warrior.health.should == 15
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
end
