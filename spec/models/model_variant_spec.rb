require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelVariant do
  before(:each) do
    @model_variant = ModelVariant.new
  end

  it "should be valid" do
    @model_variant.should be_valid
  end
end
