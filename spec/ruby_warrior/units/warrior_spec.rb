require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Warrior do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
  end
  
  # TODO pass proxy instead of warrior so player can't hack it as easily
  it "should call player.turn and pass warrior to player" do
    player = stub
    player.expects(:turn).with(@warrior)
    @warrior.stubs(:player).returns(player)
    @warrior.turn
  end
  
  it "should call Player.new the first time loading player, and return same object next time" do
    Player = Class.new
    Player.expects(:new).returns('player').times(1)
    2.times do
      @warrior.player.should == 'player'
    end
  end
  
  it "should not have walk ability initially" do
    @warrior.should_not respond_to(:walk!)
  end
  
  it "should have walk ability once added" do
    @warrior.add_action(:walk)
    walk = stub
    RubyWarrior::Abilities::Walk.expects(:new).with(@warrior).returns(walk)
    walk.expects(:perform).with(:forward)
    @warrior.walk! :forward
  end
end
