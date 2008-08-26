require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/classifieds/show.html.erb" do
  include Admin::ClassifiedsHelper
  
  before(:each) do
    @classified = mock_model(Classified)
    @classified.stub!(:stock_code).and_return("MyString")
    @classified.stub!(:model_variant_id).and_return("1")
    @classified.stub!(:physical).and_return(Classified.new)
    @classified.stub!(:salesperson).and_return(Salesperson.new)
    @classified.stub!(:year).and_return("1")
    @classified.stub!(:price_in_cents).and_return("1")
    @classified.stub!(:colour).and_return("MyString")
    @classified.stub!(:reg_num).and_return("MyString")
    @classified.stub!(:mileage).and_return("1")
    @classified.stub!(:features).and_return("MyText")
    @classified.stub!(:img_url).and_return("MyString")
    @classified.stub!(:days_in_stock).and_return("1")
    @classified.stub!(:removed_at).and_return(Time.now)
    @classified.stub!(:has_service_history).and_return(false)
    @classified.stub!("cyberstock?").and_return(false)
    @classified.stub!(:expires_on).and_return(Date.today)

    assigns[:classified] = @classified
  end

  it "should render attributes in <p>" do
    render "/admin/classifieds/show.html.erb"
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
end

