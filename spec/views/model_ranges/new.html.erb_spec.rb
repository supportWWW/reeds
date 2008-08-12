require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_ranges/new.html.erb" do
  include ModelRangesHelper
  
  before(:each) do
    @model_range = mock_model(ModelRange)
    @model_range.stub!(:new_record?).and_return(true)
    @model_range.stub!(:name).and_return("MyString")
    @model_range.stub!(:make_id).and_return("1")
    assigns[:model_range] = @model_range
  end

  it "should render new form" do
    render "/model_ranges/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_model_ranges_path) do
      with_tag("input#model_range_name[name=?]", "model_range[name]")
    end
  end
end


