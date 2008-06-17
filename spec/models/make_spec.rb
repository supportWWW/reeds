require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Make do
  before(:each) do
    @make = Make.new
  end

  it "should be valid" do
    @make.should be_valid
  end
end
