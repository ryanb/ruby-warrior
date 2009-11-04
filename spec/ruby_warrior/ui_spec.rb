require File.dirname(__FILE__) + '/../spec_helper'

describe RubyWarrior::UI do
  before(:each) do
    @ui = RubyWarrior::UI
    @config = RubyWarrior::Config
    @out = StringIO.new
    @in = StringIO.new
    @config.out_stream = @out
    @config.in_stream = @in
  end
  
  it "should add puts to out stream" do
    @ui.puts "hello"
    @out.string.should == "hello\n"
  end
  
  it "should add print to out stream without newline" do
    @ui.print "hello"
    @out.string.should == "hello"
  end
  
  it "should fetch gets from in stream" do
    @in.puts "bar"
    @in.rewind
    @ui.gets.should == "bar\n"
  end
  
  it "should gets should return empty string if no input" do
    @config.in_stream = nil
    @ui.gets.should == ""
  end
  
  it "should request text input" do
    @in.puts "bar"
    @in.rewind
    @ui.request("foo").should == "bar"
    @out.string.should == "foo"
  end
  
  it "should ask for yes/no and return true when yes" do
    @ui.expects(:request).with('foo? [yn] ').returns('y')
    @ui.ask("foo?").should be_true
  end
  
  it "should ask for yes/no and return false when no" do
    @ui.stubs(:request).returns('n')
    @ui.ask("foo?").should be_false
  end
  
  it "should ask for yes/no and return false for any input" do
    @ui.stubs(:request).returns('aklhasdf')
    @ui.ask("foo?").should be_false
  end
  
  it "should present multiple options and return selected one" do
    @ui.expects(:request).with(includes('item')).returns('2')
    @ui.choose('item', [:foo, :bar, :test]).should == :bar
    @out.string.should include('[1] foo')
    @out.string.should include('[2] bar')
    @out.string.should include('[3] test')
  end
  
  it "choose should accept array as option" do
    @ui.stubs(:request).returns('3')
    @ui.choose('item', [:foo, :bar, [:tower, 'easy']]).should == :tower
    @out.string.should include('[3] easy')
  end
  
  it "choose should return option without prompt if only one item" do
    @ui.expects(:puts).never
    @ui.expects(:gets).never
    @ui.stubs(:request).returns('3')
    @ui.choose('item', [:foo]).should == :foo
  end
  
  it "choose should return first value in array of option if only on item" do
    @ui.choose('item', [[:foo, :bar]]).should == :foo
  end
  
  it "should delay after puts when specified" do
    @config.delay = 1.3
    @ui.expects(:puts).with("foo")
    @ui.expects(:sleep).with(1.3)
    @ui.puts_with_delay("foo")
  end
  
  it "should not delay puts when delay isn't specified" do
    @ui.expects(:puts).with("foo")
    @ui.expects(:sleep).never
    @ui.puts_with_delay("foo")
  end
end
