require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/classifieds/edit.html.erb" do
  include Admin::ClassifiedsHelper
  
  before do
    @classified = mock_model(Cyberstock)
    @classified.stub!(:price).and_return("1")
    @classified.stub!(:mileage).and_return("1")
    @classified.stub!(:expires_on).and_return(Date.today)
    @classified.stub!(:stock_code).and_return("1")
    @classified.stub!(:humanize).and_return("1")
    @classified.stub!(:features).and_return("1")
    @classified.stub!(:branch).and_return(Branch.new)
    assigns[:classified] = @classified
  end

  it "should render edit form" do
    render "/admin/classifieds/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_classified_path(@classified)}][method=post]") do
      with_tag('input#classified_price[name=?]', "classified[price]")
      with_tag('input#classified_mileage[name=?]', "classified[mileage]")
    end
  end
end


