require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/search/classifieds" do
  before(:each) do
  end
  
  it "should display forms" do
    result_98 = mock_model(Classified)
    result_98.should_receive(:price).and_return(Money.new(1))
    result_98.should_receive(:year).and_return(2007)
    result_98.stub!(:permalink).and_return("MyString")
    result_98.should_receive(:make).and_return(Make.new)
    result_98.should_receive(:model).and_return(Model.new)
    result_98.should_receive(:has_images?).and_return(true)
    result_99 = mock_model(Classified)
    result_99.should_receive(:price).and_return(Money.new(1))
    result_99.should_receive(:year).and_return(2007)
    result_99.stub!(:permalink).and_return("MyString")
    result_99.should_receive(:make).and_return(Make.new)
    result_99.should_receive(:model).and_return(Model.new)
    result_99.should_receive(:has_images?).and_return(true)
    
    assigns[:results] = [result_98, result_99]
    assigns[:results].stub!( :total_pages ).and_return( 1 )

    assigns[:criteria_in_words] = "My criteria"
    
    render 'search/classifieds'

    response.should have_tag("form[action=?][method=?]", find_car_path, "post")
    response.should have_tag("textarea", %r[My criteria])
  end
end
