require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Game do
  before(:each) do
    @game = RubyWarrior::Game.new
  end
  
  it "should include tower name in player path" do
    @game.stubs(:tower_name).returns('foo')
    @game.player_path.should == 'ruby-warrior/foo'
  end
end
