require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/model_ranges/edit.html.erb" do
  include ModelRangesHelper
  
  before do
    @model_range = mock_model(ModelRange)
    @model_range.stub!(:name).and_return("MyString")
    @model_range.stub!(:make_id).and_return("1")
    assigns[:model_range] = @model_range
  end

  it "should render edit form" do
    render "/model_ranges/edit.html.erb"
    
    response.should have_tag("form[action=#{model_range_path(@model_range)}][method=post]") do
      with_tag('input#model_range_name[name=?]', "model_range[name]")
    end
  end
end


