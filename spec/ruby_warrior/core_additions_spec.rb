require_relative '../spec_helper'

describe String do
  it "should wrap text at white space when over a specific character length" do
    "foo bar blah".hard_wrap(10).should == "foo bar\nblah"
  end
end
