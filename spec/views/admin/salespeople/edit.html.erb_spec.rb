require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/salespeople/edit.html.erb" do
  include Admin::SalespeopleHelper
  
  before do
    @salesperson = mock_model(Salesperson)
    @salesperson.stub!(:name).and_return("MyString")
    @salesperson.stub!(:phone).and_return("MyString")
    @salesperson.stub!(:email).and_return("MyString")
    assigns[:salesperson] = @salesperson
  end

  it "should render edit form" do
    render "/admin/salespeople/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_salesperson_path(@salesperson)}][method=post]") do
      with_tag('input#salesperson_name[name=?]', "salesperson[name]")
      with_tag('input#salesperson_phone[name=?]', "salesperson[phone]")
      with_tag('input#salesperson_email[name=?]', "salesperson[email]")
    end
  end
end


