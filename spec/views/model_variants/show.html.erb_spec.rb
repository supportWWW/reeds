require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_variants/show.html.erb" do
  include ModelVariantsHelper
  
  before(:each) do
    @model_variant = mock_model(ModelVariant)
    @model_variant.stub!(:model_id).and_return("1")
    @model_variant.stub!(:year).and_return("1")
    @model_variant.stub!(:mead_mcgrouther_code).and_return("MyString")

    assigns[:model_variant] = @model_variant
  end

  it "should render attributes in <p>" do
    render "/model_variants/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/MyString/)
  end
end

