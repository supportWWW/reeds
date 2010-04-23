require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Make do
  before(:each) do
    @make = Make.new
  end

  it "should be a Make" do
    @make.class.should == Make
  end
end
