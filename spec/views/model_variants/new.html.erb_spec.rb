require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_variants/new.html.erb" do
  include ModelVariantsHelper
  
  before(:each) do
    @model_variant = mock_model(ModelVariant)
    @model_variant.stub!(:new_record?).and_return(true)
    @model_variant.stub!(:model_id).and_return("1")
    @model_variant.stub!(:year).and_return("1")
    @model_variant.stub!(:mead_mcgrouther_code).and_return("MyString")
    assigns[:model_variant] = @model_variant
  end

  it "should render new form" do
    render "/model_variants/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_model_variants_path) do
      with_tag("input#model_variant_year[name=?]", "model_variant[year]")
      with_tag("input#model_variant_mead_mcgrouther_code[name=?]", "model_variant[mead_mcgrouther_code]")
    end
  end
end


