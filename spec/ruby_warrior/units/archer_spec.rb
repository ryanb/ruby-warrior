require "spec_helper"

describe RubyWarrior::Units::Archer do
  before(:each) { @archer = RubyWarrior::Units::Archer.new }

  it "should have look and shoot abilities" do
    expect(@archer.abilities.keys.to_set).to eq(%i[shoot! look].to_set)
  end

  it "should have shoot power of 3" do
    expect(@archer.shoot_power).to eq(3)
  end

  it "should have 7 max health" do
    expect(@archer.max_health).to eq(7)
  end

  it "should appear as a on map" do
    expect(@archer.character).to eq("a")
  end
end
