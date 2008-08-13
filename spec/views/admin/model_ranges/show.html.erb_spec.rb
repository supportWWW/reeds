require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/model_ranges/show.html.erb" do
  include Admin::ModelRangesHelper
  
  before(:each) do
    @model_range = mock_model(ModelRange)
    @model_range.stub!(:name).and_return("MyString")
    @model_range.stub!(:make_id).and_return("1")

    assigns[:model_range] = @model_range
  end

  it "should render attributes in <p>" do
    render "/admin/model_ranges/show.html.erb"
    response.should have_text(/MyString/)
  end
end

