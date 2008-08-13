require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/models/edit.html.erb" do
  include Admin::ModelsHelper
  
  before do
    @model = mock_model(Model)
    @model.stub!(:name).and_return("MyString")
    @model.stub!(:common_name).and_return("MyString")
    @model.stub!(:make_id).and_return("1")
    assigns[:model] = @model
  end

  it "should render edit form" do
    render "/admin/models/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_model_path(@model)}][method=post]") do
      with_tag('input#model_name[name=?]', "model[name]")
      with_tag('input#model_common_name[name=?]', "model[common_name]")
    end
  end
end


