require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/classifieds/edit.html.erb" do
  include Admin::ClassifiedsHelper
  
  before do
    @classified = mock_model(Classified)
    @classified.stub!(:stock_code).and_return("MyString")
    @classified.stub!(:stock_type).and_return("1")
    @classified.stub!(:model_variant_id).and_return("1")
    @classified.stub!(:year).and_return("1")
    @classified.stub!(:price_in_cents).and_return("1")
    @classified.stub!(:colour).and_return("MyString")
    @classified.stub!(:reg_num).and_return("MyString")
    @classified.stub!(:mileage).and_return("1")
    @classified.stub!(:features).and_return("MyText")
    @classified.stub!(:img_url).and_return("MyString")
    @classified.stub!(:best_buy).and_return(false)
    @classified.stub!(:days_in_stock).and_return("1")
    @classified.stub!(:removed_at).and_return(Time.now)
    @classified.stub!(:has_service_history).and_return(false)
    @classified.stub!(:cyberstock).and_return(false)
    @classified.stub!(:expires_at).and_return(Time.now)
    assigns[:classified] = @classified
  end

  it "should render edit form" do
    render "/admin/classifieds/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_classified_path(@classified)}][method=post]") do
      with_tag('input#classified_stock_code[name=?]', "classified[stock_code]")
      with_tag('input#classified_stock_type[name=?]', "classified[stock_type]")
      with_tag('input#classified_year[name=?]', "classified[year]")
      with_tag('input#classified_price_in_cents[name=?]', "classified[price_in_cents]")
      with_tag('input#classified_colour[name=?]', "classified[colour]")
      with_tag('input#classified_reg_num[name=?]', "classified[reg_num]")
      with_tag('input#classified_mileage[name=?]', "classified[mileage]")
      with_tag('textarea#classified_features[name=?]', "classified[features]")
      with_tag('input#classified_img_url[name=?]', "classified[img_url]")
      with_tag('input#classified_best_buy[name=?]', "classified[best_buy]")
      with_tag('input#classified_days_in_stock[name=?]', "classified[days_in_stock]")
      with_tag('input#classified_has_service_history[name=?]', "classified[has_service_history]")
      with_tag('input#classified_cyberstock[name=?]', "classified[cyberstock]")
    end
  end
end


