require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/index.html.erb" do
  include ModelsHelper
  
  before(:each) do
    model_98 = mock_model(Model)
    model_98.should_receive(:name).and_return("MyString")
    model_98.should_receive(:common_name).and_return("MyString")
    model_98.should_receive(:make_id).and_return("1")
    model_99 = mock_model(Model)
    model_99.should_receive(:name).and_return("MyString")
    model_99.should_receive(:common_name).and_return("MyString")
    model_99.should_receive(:make_id).and_return("1")

    assigns[:models] = [model_98, model_99]
  end

  it "should render list of models" do
    render "/models/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

