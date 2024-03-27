require "spec_helper"

describe RubyWarrior::Abilities::Rescue do
  before(:each) do
    @warrior = RubyWarrior::Units::Warrior.new
    @rescue = RubyWarrior::Abilities::Rescue.new(@warrior)
  end

  it "should rescue captive" do
    captive = RubyWarrior::Units::Captive.new
    captive.position = double
    expect(@rescue).to receive(:space).with(:forward).and_return(double(captive?: true))
    expect(@rescue).to receive(:unit).with(:forward).and_return(captive)
    expect(@warrior).to receive(:earn_points).with(20)
    @rescue.perform
    expect(captive.position).to be_nil
  end

  it "should do nothing to other unit if not bound" do
    unit = RubyWarrior::Units::Base.new
    unit.position = double
    expect(@rescue).to receive(:space).with(:forward).and_return(double(captive?: false))
    expect(@rescue).to receive(:unit).with(:forward).never
    expect(@warrior).to receive(:earn_points).never
    @rescue.perform
    expect(unit.position).to_not be_nil
  end

  it "should release other unit when bound" do
    unit = RubyWarrior::Units::Base.new
    unit.bind
    unit.position = double
    expect(@rescue).to receive(:space).with(:forward).and_return(double(captive?: true))
    expect(@rescue).to receive(:unit).with(:forward).and_return(unit)
    expect(@warrior).to receive(:earn_points).never
    @rescue.perform
    expect(unit).to_not be_bound
    expect(unit.position).to_not be_nil
  end
end
