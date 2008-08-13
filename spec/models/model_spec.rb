require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Model do
  before(:each) do
    @model = Model.new
  end

  it "should be Model" do
    @model.class.should == Model
  end
end
