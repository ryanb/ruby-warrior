require "spec_helper"

describe RubyWarrior::Abilities::Walk do
  before(:each) do
    @space = double(empty?: true, unit: nil)
    @position = double(relative_space: @space, move: nil)
    @walk = RubyWarrior::Abilities::Walk.new(double(position: @position, say: nil))
  end

  it "should move position forward when calling perform" do
    expect(@position).to receive(:move).with(1, 0)
    @walk.perform
  end

  it "should move position right if that is direction" do
    expect(@position).to receive(:move).with(0, 1)
    @walk.perform(:right)
  end

  it "should keep position if something is in the way" do
    allow(@position).to receive(:move).and_raise("shouldn't be called")
    allow(@space).to receive(:empty?).and_return(false)
    expect { @walk.perform(:right) }.to_not raise_error
  end
end
