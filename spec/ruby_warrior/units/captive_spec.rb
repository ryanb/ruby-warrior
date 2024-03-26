require 'spec_helper'

describe RubyWarrior::Units::Captive do
  before(:each) do
    @captive = RubyWarrior::Units::Captive.new
  end

  it "should have 1 max health" do
    expect(@captive.max_health).to eq(1)
  end

  it "should appear as C on map" do
    expect(@captive.character).to eq("C")
  end

  it "should be bound by default" do
    expect(@captive).to be_bound
  end

  it "should not have explode ability by default (this should be added when needed)" do
    expect(@captive.abilities).to_not include(:explode!)
  end
end
