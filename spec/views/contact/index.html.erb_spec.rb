require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/contact/index" do
  before(:each) do
    salespeople = []
    salespeople.stub!(:managers).and_return([Salesperson.new(:email => "test@spam.com")])
    branch_98 = mock_model(Branch)
    branch_98.stub!(:name).and_return("Cape Town")
    branch_98.should_receive(:phone).and_return("MyString")
    branch_98.should_receive(:fax).and_return("MyString")
    branch_98.should_receive(:address).and_return("MyString")
    branch_98.should_receive(:salespeople).and_return(salespeople)
    branch_98.should_receive(:image).and_return(nil)
    branch_99 = mock_model(Branch)
    branch_99.stub!(:name).and_return("MyString")
    branch_99.should_receive(:phone).and_return("MyString")
    branch_99.should_receive(:fax).and_return("MyString")
    branch_99.should_receive(:address).and_return("MyString")
    branch_99.should_receive(:salespeople).and_return(salespeople)
    branch_99.should_receive(:image).and_return(nil)
    
    assigns[:branches] = [branch_98, branch_99]

    render 'contact/index'
  end
  
  it "should show branches and salespeople" do
    response.should have_tag("h3", "Cape Town")
  end
end
