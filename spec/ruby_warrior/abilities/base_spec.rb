require 'spec_helper'

describe RubyWarrior::Abilities::Base do
  before(:each) do
    @unit = stub
    @ability = RubyWarrior::Abilities::Base.new(@unit)
  end
  
  it "should have offset for directions" do
    expect(@ability.offset(:forward)).to eq [1, 0]
    expect(@ability.offset(:right)).to eq [0, 1]
    expect(@ability.offset(:backward)).to eq [-1, 0]
    expect(@ability.offset(:left)).to eq [0, -1]
  end
  
  it "should have offset for relative forward/right amounts" do
    expect(@ability.offset(:forward, 2)).to eq [2, 0]
    expect(@ability.offset(:forward, 2, 1)).to eq [2, -1]
    expect(@ability.offset(:right, 2, 1)).to eq [1, 2]
    expect(@ability.offset(:backward, 2, 1)).to eq [-2, 1]
    expect(@ability.offset(:left, 2, 1)).to eq [-1, -2]
  end
  
  it "should fetch unit at given direction with distance" do
    @ability.expects(:space).with(:right, 3, 1).returns(stub(:unit => 'unit'))
    expect(@ability.unit(:right, 3, 1)).to eq 'unit'
  end
  
  it "should have no description" do
    expect(@ability.description).to be_nil
  end
  
  it "should raise an exception if direction isn't recognized" do
    expect{
      @ability.verify_direction(:foo)
    }.to raise_error("Unknown direction :foo. Should be :forward, :backward, :left or :right.")
  end
end
