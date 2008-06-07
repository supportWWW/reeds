require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/branches/edit.html.erb" do
  include BranchesHelper
  
  before do
    @branch = mock_model(Branch)
    @branch.stub!(:name).and_return("MyString")
    assigns[:branch] = @branch
  end

  it "should render edit form" do
    render "/branches/edit.html.erb"
    
    response.should have_tag("form[action=#{branch_path(@branch)}][method=post]") do
      with_tag('input#branch_name[name=?]', "branch[name]")
    end
  end
end


