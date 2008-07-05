require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Units::Sludge do
  before(:each) do
    @sludge = RubyWarrior::Units::Sludge.new
  end
  
  it "should have attack ability" do
    @sludge.should respond_to(:attack!)
  end
end
