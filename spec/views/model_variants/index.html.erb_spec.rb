require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_variants/index.html.erb" do
  include ModelVariantsHelper
  
  before(:each) do
    model_variant_98 = mock_model(ModelVariant)
    model_variant_98.should_receive(:model).and_return(Model.new)
    model_variant_98.should_receive(:year).and_return("1")
    model_variant_98.should_receive(:mead_mcgrouther_code).and_return("MyString")
    model_variant_99 = mock_model(ModelVariant)
    model_variant_99.should_receive(:model).and_return(Model.new)
    model_variant_99.should_receive(:year).and_return("1")
    model_variant_99.should_receive(:mead_mcgrouther_code).and_return("MyString")

    assigns[:model_variants] = [model_variant_98, model_variant_99]
    assigns[:model_variants].stub!(:total_pages).and_return(1)
  end

  it "should render list of model_variants" do
    render "/model_variants/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

