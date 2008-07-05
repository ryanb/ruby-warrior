require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Walk do
  before(:each) do
    @position = stub_everything
    @walk = RubyWarrior::Abilities::Walk.new(stub(:position => @position, :say => nil))
  end
  
  it "should move position forward when calling perform" do
    @position.expects(:move).with(1, 0)
    @walk.perform
  end
  
  it "should move position right if that is direction" do
    @position.expects(:move).with(0, 1)
    @walk.perform(:right)
  end
  
  it "should keep position if something is in the way" do
    @position.stubs(:move).raises("shouldn't be called")
    @walk.stubs(:get).returns(stub)
    lambda { @walk.perform(:right) }.should_not raise_error(Exception)
  end
end
