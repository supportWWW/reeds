require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/models/new.html.erb" do
  include ModelsHelper
  
  before(:each) do
    @model = mock_model(Model)
    @model.stub!(:new_record?).and_return(true)
    @model.stub!(:name).and_return("MyString")
    @model.stub!(:common_name).and_return("MyString")
    @model.stub!(:make_id).and_return("1")
    assigns[:model] = @model
  end

  it "should render new form" do
    render "/models/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", models_path) do
      with_tag("input#model_name[name=?]", "model[name]")
      with_tag("input#model_common_name[name=?]", "model[common_name]")
    end
  end
end


