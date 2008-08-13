require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/models/index.html.erb" do
  include Admin::ModelsHelper
  
  before(:each) do
    model_98 = mock_model(Model)
    model_98.should_receive(:common_name).and_return("MyString")
    model_98.should_receive(:make).and_return(Make.new)
    model_99 = mock_model(Model)
    model_99.should_receive(:common_name).and_return("MyString")
    model_99.should_receive(:make).and_return(Make.new)

    assigns[:models] = [model_98, model_99]
    assigns[:models].stub!(:total_pages).and_return(1)
  end

  it "should render list of models" do
    render "/admin/models/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

