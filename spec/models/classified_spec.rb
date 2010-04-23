require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Classified do
  before(:each) do
    @classified = Classified.new
  end

  it "should be Classified" do
    @classified.class.should == Classified
  end
end
