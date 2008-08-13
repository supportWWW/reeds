require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/models/show.html.erb" do
  include Admin::ModelsHelper
  
  before(:each) do
    @model = mock_model(Model)
    @model.stub!(:name).and_return("MyString")
    @model.stub!(:common_name).and_return("MyString")
    @model.stub!(:make_id).and_return("1")

    assigns[:model] = @model
  end

  it "should render attributes in <p>" do
    render "/admin/models/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

