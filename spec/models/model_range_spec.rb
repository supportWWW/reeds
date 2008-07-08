require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelRange do
  before(:each) do
    @model_range = ModelRange.new
  end

  it "should be valid" do
    @model_range.should be_valid
  end
end
