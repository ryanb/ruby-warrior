require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Tower do
  before(:each) do
    @tower = RubyWarrior::Tower.new('path/to/tower')
  end
  
  it "should consider last part of path as name" do
    @tower.name.should == 'tower'
  end
  
  it "should use name when converting to string" do
    @tower.to_s.should == @tower.name
  end
end
