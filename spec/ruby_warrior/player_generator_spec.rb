require 'spec_helper'

describe RubyWarrior::PlayerGenerator do
  before(:each) do
    @level = RubyWarrior::Level.new(RubyWarrior::Profile.new, 15)
    @generator = RubyWarrior::PlayerGenerator.new(@level)
  end

  it "should know templates path" do
    expect(@generator.templates_path).to eq(File.expand_path("../../../templates", __FILE__))
  end
end
