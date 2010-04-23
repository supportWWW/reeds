require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/salespeople/show.html.erb" do
  include Admin::SalespeopleHelper
  
  before(:each) do
    @salesperson = mock_model(Salesperson)
    @salesperson.stub!(:name).and_return("MyString")
    @salesperson.stub!(:phone).and_return("MyString")
    @salesperson.stub!(:email).and_return("MyString")
    @salesperson.stub!(:job_title).and_return("MyString")
    @salesperson.stub!(:sms_contact_me).and_return(true)
    @salesperson.stub!(:receive_web_leads).and_return(true)

    assigns[:salesperson] = @salesperson
  end

  it "should render attributes in <p>" do
    render "/admin/salespeople/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

