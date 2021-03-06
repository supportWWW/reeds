require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/salespeople/new.html.erb" do
  include Admin::SalespeopleHelper
  
  before(:each) do
    @salesperson = mock_model(Salesperson)
    @salesperson.stub!(:new_record?).and_return(true)
    @salesperson.stub!(:name).and_return("MyString")
    @salesperson.stub!(:phone).and_return("MyString")
    @salesperson.stub!(:email).and_return("MyString")
    @salesperson.stub!(:job_title).and_return("MyString")
    @salesperson.stub!(:sms_contact_me).and_return(true)
    @salesperson.stub!(:receive_web_leads).and_return(true)
    assigns[:salesperson] = @salesperson
  end

  it "should render new form" do
    render "/admin/salespeople/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_salespeople_path) do
      with_tag("input#salesperson_name[name=?]", "salesperson[name]")
      with_tag("input#salesperson_phone[name=?]", "salesperson[phone]")
      with_tag("input#salesperson_email[name=?]", "salesperson[email]")
    end
  end
end


