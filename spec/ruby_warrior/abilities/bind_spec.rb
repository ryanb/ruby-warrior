require "spec_helper"

describe RubyWarrior::Abilities::Bind do
  before(:each) { @bind = RubyWarrior::Abilities::Bind.new(double(say: nil)) }

  it "should bind recipient" do
    receiver = RubyWarrior::Units::Base.new
    allow(@bind).to receive(:unit).and_return(receiver)
    @bind.perform
    expect(receiver).to be_bound
  end

  it "should do nothing if no recipient" do
    allow(@bind).to receive(:unit).and_return(nil)
    expect { @bind.perform }.to_not raise_error
  end
end
