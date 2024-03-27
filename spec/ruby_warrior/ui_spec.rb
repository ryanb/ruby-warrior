require "spec_helper"

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
    expect(@out.string).to eq("hello\n")
  end

  it "should add print to out stream without newline" do
    @ui.print "hello"
    expect(@out.string).to eq("hello")
  end

  it "should fetch gets from in stream" do
    @in.puts "bar"
    @in.rewind
    expect(@ui.gets).to eq("bar\n")
  end

  it "should gets should return empty string if no input" do
    @config.in_stream = nil
    expect(@ui.gets).to eq("")
  end

  it "should request text input" do
    @in.puts "bar"
    @in.rewind
    expect(@ui.request("foo")).to eq("bar")
    expect(@out.string).to eq("foo")
  end

  it "should ask for yes/no and return true when yes" do
    expect(@ui).to receive(:request).with("foo? [yn] ").and_return("y")
    expect(@ui.ask("foo?")).to eq(true)
  end

  it "should ask for yes/no and return false when no" do
    allow(@ui).to receive(:request).and_return("n")
    expect(@ui.ask("foo?")).to eq(false)
  end

  it "should ask for yes/no and return false for any input" do
    allow(@ui).to receive(:request).and_return("aklhasdf")
    expect(@ui.ask("foo?")).to eq(false)
  end

  it "should present multiple options and return selected one" do
    expect(@ui).to receive(:request).with(include("item")).and_return("2")
    expect(@ui.choose("item", %i[foo bar test])).to eq(:bar)
    expect(@out.string).to include("[1] foo")
    expect(@out.string).to include("[2] bar")
    expect(@out.string).to include("[3] test")
  end

  it "choose should accept array as option" do
    allow(@ui).to receive(:request).and_return("3")
    expect(@ui.choose("item", [:foo, :bar, [:tower, "easy"]])).to eq(:tower)
    expect(@out.string).to include("[3] easy")
  end

  it "choose should return option without prompt if only one item" do
    expect(@ui).to receive(:puts).never
    expect(@ui).to receive(:gets).never
    allow(@ui).to receive(:request).and_return("3")
    expect(@ui.choose("item", [:foo])).to eq(:foo)
  end

  it "choose should return first value in array of option if only on item" do
    expect(@ui.choose("item", [%i[foo bar]])).to eq(:foo)
  end

  it "should delay after puts when specified" do
    @config.delay = 1.3
    expect(@ui).to receive(:puts).with("foo")
    expect(@ui).to receive(:sleep).with(1.3)
    @ui.puts_with_delay("foo")
  end

  it "should not delay puts when delay isn't specified" do
    expect(@ui).to receive(:puts).with("foo")
    expect(@ui).to receive(:sleep).never
    @ui.puts_with_delay("foo")
  end
end
