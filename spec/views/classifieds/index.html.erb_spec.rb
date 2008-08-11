require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/classifieds/index.html.erb" do
  include ClassifiedsHelper
  
  before(:each) do
    classified_98 = mock_model(Classified)
    classified_98.should_receive(:stock_code).and_return("MyString")
    classified_98.should_receive(:stock_type).and_return("1")
    classified_98.should_receive(:model_variant_id).and_return("1")
    classified_98.should_receive(:year).and_return("2008")
    classified_98.should_receive(:price_in_cents).and_return("112")
    classified_98.should_receive(:colour).and_return("MyString")
    classified_98.should_receive(:reg_num).and_return("MyString")
    classified_98.should_receive(:mileage).and_return("1")
    classified_98.should_receive(:features).and_return("MyText")
    classified_98.should_receive(:img_url).and_return("MyString")
    classified_98.should_receive(:best_buy).and_return(false)
    classified_98.should_receive(:days_in_stock).and_return("1")
    classified_98.should_receive(:removed_at).and_return(Time.now)
    classified_98.should_receive(:has_service_history).and_return(false)
    classified_98.should_receive(:cyberstock).and_return(false)
    classified_98.should_receive(:expires_at).and_return(Time.now)
    classified_99 = mock_model(Classified)
    classified_99.should_receive(:stock_code).and_return("MyString")
    classified_99.should_receive(:stock_type).and_return("1")
    classified_99.should_receive(:model_variant_id).and_return("1")
    classified_99.should_receive(:year).and_return("2008")
    classified_99.should_receive(:price_in_cents).and_return("112")
    classified_99.should_receive(:colour).and_return("MyString")
    classified_99.should_receive(:reg_num).and_return("MyString")
    classified_99.should_receive(:mileage).and_return("1")
    classified_99.should_receive(:features).and_return("MyText")
    classified_99.should_receive(:img_url).and_return("MyString")
    classified_99.should_receive(:best_buy).and_return(false)
    classified_99.should_receive(:days_in_stock).and_return("1")
    classified_99.should_receive(:removed_at).and_return(Time.now)
    classified_99.should_receive(:has_service_history).and_return(false)
    classified_99.should_receive(:cyberstock).and_return(false)
    classified_99.should_receive(:expires_at).and_return(Time.now)

    assigns[:classifieds] = [classified_98, classified_99]
  end

  it "should render list of classifieds" do
    render "/classifieds/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "2008", 2)
    response.should have_tag("tr>td", "112", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "No", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "No", 2)
    response.should have_tag("tr>td", "No", 2)
  end
end

