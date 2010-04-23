require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  before(:each) do
    @image = Image.new
  end

  it "should be Image" do
    @image.class.should == Image
  end
end
