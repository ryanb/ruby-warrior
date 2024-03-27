require "spec_helper"

describe String do
  it "should wrap text at white space when over a specific character length" do
    expect("foo bar blah".hard_wrap(10)).to eq("foo bar\nblah")
  end
end
