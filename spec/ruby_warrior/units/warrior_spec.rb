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
  
  # TODO pass proxy instead of warrior so player can't hack it as easily
  it "should call player.turn and pass warrior to player" do
    player = stub
    player.expects(:turn).with(@warrior)
    @warrior.stubs(:player).returns(player)
    @warrior.turn
  end
  
  it "should call Player.new the first time loading player, and return same object next time" do
    Player.expects(:new).returns('player').times(1)
    2.times do
      @warrior.player.should == 'player'
    end
  end
end
