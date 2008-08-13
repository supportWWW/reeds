require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/model_variants/edit.html.erb" do
  include Admin::ModelVariantsHelper
  
  before do
    @model_variant = mock_model(ModelVariant)
    @model_variant.stub!(:model_id).and_return("1")
    @model_variant.stub!(:year).and_return("1")
    @model_variant.stub!(:mead_mcgrouther_code).and_return("MyString")
    assigns[:model_variant] = @model_variant
  end

  it "should render edit form" do
    render "/admin/model_variants/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_model_variant_path(@model_variant)}][method=post]") do
      with_tag('input#model_variant_year[name=?]', "model_variant[year]")
      with_tag('input#model_variant_mead_mcgrouther_code[name=?]', "model_variant[mead_mcgrouther_code]")
    end
  end
end


