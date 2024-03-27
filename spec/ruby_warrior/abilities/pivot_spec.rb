require "spec_helper"

describe RubyWarrior::Abilities::Pivot do
  before(:each) do
    @position = double
    @pivot = RubyWarrior::Abilities::Pivot.new(double(position: @position, say: nil))
  end

  it "should flip around when not passing arguments" do
    expect(@position).to receive(:rotate).with(2)
    @pivot.perform
  end

  it "should rotate 1 when pivoting right" do
    expect(@position).to receive(:rotate).with(1)
    @pivot.perform(:right)
  end
end
