require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_ranges/index.html.erb" do
  include ModelRangesHelper
  
  before(:each) do
    model_range_98 = mock_model(ModelRange)
    model_range_98.should_receive(:name).and_return("MyString")
    model_range_98.should_receive(:make_id).and_return("1")
    model_range_99 = mock_model(ModelRange)
    model_range_99.should_receive(:name).and_return("MyString")
    model_range_99.should_receive(:make_id).and_return("1")

    assigns[:model_ranges] = [model_range_98, model_range_99]
  end

  it "should render list of model_ranges" do
    render "/model_ranges/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

