require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/search/new_vehicles" do
  before(:each) do
  end
  
  it "should display forms" do
    new_vehcile = mock_model(NewVehicle)
    new_vehcile.stub!(:permalink).and_return("permalink1")
    result_98 = mock_model(Classified)
    result_98.should_receive(:name).and_return("MyString")
    result_98.should_receive(:price).and_return(Money.new(1))
    result_98.should_receive(:new_vehicle).and_return(new_vehcile)
    result_98.should_receive(:model_range).and_return(ModelRange.new(:make => Make.new))
    result_99 = mock_model(Classified)
    result_99.should_receive(:name).and_return("MyString")
    result_99.should_receive(:price).and_return(Money.new(1))
    result_99.should_receive(:new_vehicle).and_return(new_vehcile)
    result_99.should_receive(:model_range).and_return(ModelRange.new(:make => Make.new))
    
    assigns[:results] = [result_98, result_99]
    assigns[:results].stub!( :total_pages ).and_return( 1 )

    assigns[:criteria_in_words] = "My criteria"
    
    render 'search/new_vehicles'

    response.should have_tag("form[action=?][method=?]", find_car_path, "post")
    response.should have_tag("textarea", %r[My criteria])
  end
end
