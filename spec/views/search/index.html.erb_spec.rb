require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/search/index" do
  before(:each) do
  end
  
  it "should display heading" do
    result_98 = mock_model(Classified)
    result_99 = mock_model(Classified)
    
    assigns[:results] = [result_98, result_99]
    assigns[:results].stub!( :total_pages ).and_return( 1 )

    render 'search/index'

    response.should have_tag('h2', %r[Search results])
    response.should have_tag("form[action=?][method=?]", find_car_path, "post")
  end
end
