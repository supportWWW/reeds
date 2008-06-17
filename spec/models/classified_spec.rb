require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Classified do
  before(:each) do
    @classified = Classified.new
  end

  it "should be valid" do
    @classified.should be_valid
  end
end
