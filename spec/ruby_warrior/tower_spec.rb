require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::Tower do
  before(:each) do
    @tower = RubyWarrior::Tower.new('foo')
  end
  
  it "should know its name" do
    @tower.name.should == 'foo'
  end
  
  it "should grab level paths" do
    @tower.stubs(:path).returns('/foo/bar')
    Dir.expects(:[]).with('/foo/bar/level*').returns(['level_file'])
    @tower.level_files.should == ['level_file']
  end
  
  it "should include /towers/foo in path" do
    @tower.path.should include('/towers/foo')
  end
  
  it "should call File.expand_path in path" do
    File.expects(:expand_path)
    @tower.path
  end
  
  it "call LevelBuilder.build for building file" do
    @tower.stubs(:level_files).returns(['foo', 'bar', 'blah'])
    RubyWarrior::LevelBuilder.expects(:build).with('bar')
    @tower.build_level(2)
  end
end
