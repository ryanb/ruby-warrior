require File.dirname(__FILE__) + '/../../spec_helper'

class Player
  def turn(warrior)
  end
end

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
    Player.expects(:new).returns('player').times(1)
    2.times do
      @warrior.player.should == 'player'
    end
  end
  
  it "should not have walk ability initially" do
    @warrior.should_not respond_to(:walk!)
  end
  
  it "should have walk ability once added" do
    @warrior.add_actions(:walk)
    walk = stub
    RubyWarrior::Abilities::Walk.expects(:new).with(@warrior).returns(walk)
    walk.expects(:perform).with(:forward)
    @warrior.walk! :forward
  end
  
  it "should be able to add multiple actions" do
    @warrior.add_actions(:walk, :wait)
    @warrior.should respond_to(:walk!)
    @warrior.should respond_to(:wait!)
  end
  
  it "should not be able to call more than one action" do
    @warrior.add_actions(:walk)
    @warrior.walk!
    lambda { @warrior.walk! }.should raise_error(Exception)
  end
  
  it "should be able to action twice if on separate turn" do
    @warrior.add_actions(:walk)
    @warrior.walk!
    @warrior.turn
    lambda { @warrior.walk! }.should_not raise_error(Exception)
  end
end
