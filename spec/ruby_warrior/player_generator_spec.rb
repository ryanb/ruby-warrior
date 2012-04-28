require 'spec_helper'

describe RubyWarrior::PlayerGenerator do
  before(:each) do
    @level = RubyWarrior::Level.new(RubyWarrior::Profile.new, 15)
    @generator = RubyWarrior::PlayerGenerator.new(@level)
  end
  
  it "should know templates path" do
    @generator.templates_path.should == File.expand_path(File.dirname(__FILE__) + "/../../templates")
  end
end
