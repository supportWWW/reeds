require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/classifieds/show.html.erb" do
  include ClassifiedsHelper
  
  before(:each) do
    @classified = mock_model(Classified)
    @classified.stub!(:stock_code).and_return("MyString")
    @classified.stub!(:humanize).and_return("MyString")
    @classified.stub!(:year).and_return("1")
    @classified.stub!(:price).and_return(Money.new(1))
    @classified.stub!(:price_in_cents).and_return(1)
    @classified.stub!(:colour).and_return("MyString")
    @classified.stub!(:reg_num).and_return("MyString")
    @classified.stub!(:mileage).and_return("1")
    @classified.stub!(:features).and_return("MyText")
    @classified.stub!(:img_url).and_return("MyString")
    @classified.stub!(:days_in_stock).and_return("1")
    @classified.stub!(:has_service_history).and_return(false)
    @classified.stub!(:removed?).and_return(false)
    @classified.stub!(:make).and_return(Make.new)
    @classified.stub!(:model).and_return(Model.new)

    assigns[:classified] = @classified
    @request.env["HTTP_REFERER"] = "http://localhost/search"
    @request.env["SERVER_NAME"] = "localhost"
  end

  it "should render attributes in <p>" do
    render "/classifieds/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/1/)
    response.should have_text(/MyText/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
    response.should have_text(/1/)
    response.should have_text(/als/)
    response.should have_text(/als/)
  end
  
  it "should show follow up forms for removed car" do
    @classified.stub!(:removed?).and_return(true)
    render "/classifieds/show.html.erb"

    response.should have_tag("form[action=?][method=?]", find_car_path, "post")
    response.should have_tag("textarea", %r[Make: \nModel: \nPrice range: \nYear: ])
  end
end

