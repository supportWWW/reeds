require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/salespeople/show.html.erb" do
  include SalespeopleHelper
  
  before(:each) do
    @salesperson = mock_model(Salesperson)
    @salesperson.stub!(:name).and_return("MyString")
    @salesperson.stub!(:phone).and_return("MyString")
    @salesperson.stub!(:email).and_return("MyString")

    assigns[:salesperson] = @salesperson
  end

  it "should render attributes in <p>" do
    render "/salespeople/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

