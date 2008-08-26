require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/salespeople/index.html.erb" do
  include Admin::SalespeopleHelper
  
  before(:each) do
    salesperson_98 = mock_model(Salesperson)
    salesperson_98.should_receive(:name).and_return("MyString")
    salesperson_98.should_receive(:phone).and_return("MyString")
    salesperson_98.should_receive(:email).and_return("MyString")
    salesperson_98.should_receive(:job_title).and_return("MyString")
    salesperson_99 = mock_model(Salesperson)
    salesperson_99.should_receive(:name).and_return("MyString")
    salesperson_99.should_receive(:phone).and_return("MyString")
    salesperson_99.should_receive(:email).and_return("MyString")
    salesperson_99.should_receive(:job_title).and_return("MyString")

    assigns[:salespeople] = [salesperson_98, salesperson_99]
  end

  it "should render list of salespeople" do
    render "/admin/salespeople/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

