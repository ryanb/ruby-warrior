require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Profile do
  before(:each) do
    @profile = RubyWarrior::Profile.new('path/to/tower', 'Warrior')
  end
  
  it "should have warrior name" do
    @profile.warrior_name.should == 'Warrior'
  end
  
  it "should load tower from path" do
    RubyWarrior::Tower.expects(:new).with('path/to/tower').returns('tower')
    @profile.tower.should == 'tower'
  end
  
  it "should start level number at 0" do
    @profile.level_number.should be_zero
  end
  
  it "should start score at 0 and allow it to increment" do
    @profile.score.should be_zero
    @profile.score += 5
    @profile.score.should == 5
  end
  
  it "should have no abilities and allow adding" do
    @profile.abilities.should == []
    @profile.abilities += [:foo, :bar]
    @profile.abilities.should == [:foo, :bar]
  end
  
  it "should encode with marshal + base64" do
    @profile.encode.should == Base64.encode64(Marshal.dump(@profile))
  end
  
  it "should decode with marshal + base64" do
    RubyWarrior::Profile.decode(@profile.encode).warrior_name.should == @profile.warrior_name
  end
  
  it "load should read file and decode" do
    File.expects(:read).with('path/to/.profile').returns('encoded_profile')
    RubyWarrior::Profile.expects(:decode).with('encoded_profile').returns('profile')
    RubyWarrior::Profile.load('path/to/.profile').should == 'profile'
  end
  
  it "should have a nice string representation" do
    @profile.to_s.should == "Warrior - tower - level 0 - score 0"
  end
end
