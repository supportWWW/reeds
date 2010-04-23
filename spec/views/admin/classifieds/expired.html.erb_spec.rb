require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/classifieds/expired.html.erb" do
  include Admin::ClassifiedsHelper
  
  before(:each) do
    classified_98 = mock_model(Classified, :humanize => "MyString")
    classified_98.should_receive(:stock_code).and_return("MyString")
    classified_98.should_receive(:price).and_return(mock("Price", :format => "112"))
    classified_98.should_receive(:colour).and_return("MyString")
    classified_98.should_receive(:mileage).and_return("1")
    classified_98.should_receive(:days_in_stock).and_return("1")
    classified_98.should_receive(:physical_stock).and_return("1")
    classified_99 = mock_model(Classified, :humanize => "MyString")
    classified_99.should_receive(:stock_code).and_return("MyString")
    classified_99.should_receive(:price).and_return(mock("Price", :format => "112"))
    classified_99.should_receive(:colour).and_return("MyString")
    classified_99.should_receive(:mileage).and_return("1")
    classified_99.should_receive(:days_in_stock).and_return("1")
    classified_99.should_receive(:physical_stock).and_return("1")

    assigns[:classifieds] = [classified_98, classified_99]
  end

  it "should render list of classifieds" do
    render "/admin/classifieds/expired.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "112", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

