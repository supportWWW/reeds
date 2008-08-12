require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/salespeople/new.html.erb" do
  include SalespeopleHelper
  
  before(:each) do
    @salesperson = mock_model(Salesperson)
    @salesperson.stub!(:new_record?).and_return(true)
    @salesperson.stub!(:name).and_return("MyString")
    @salesperson.stub!(:phone).and_return("MyString")
    @salesperson.stub!(:email).and_return("MyString")
    assigns[:salesperson] = @salesperson
  end

  it "should render new form" do
    render "/salespeople/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_salespeople_path) do
      with_tag("input#salesperson_name[name=?]", "salesperson[name]")
      with_tag("input#salesperson_phone[name=?]", "salesperson[phone]")
      with_tag("input#salesperson_email[name=?]", "salesperson[email]")
    end
  end
end


