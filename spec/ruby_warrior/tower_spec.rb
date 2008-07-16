require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Tower do
  before(:each) do
    @tower = RubyWarrior::Tower.new('path/to/tower')
  end
  
  it "should consider last part of path as name" do
    @tower.name.should == 'tower'
  end
end
