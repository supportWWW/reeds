require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactController do

  #Delete these examples and add some real ones
  it "should use ContactController" do
    controller.should be_an_instance_of(ContactController)
  end


  describe "GET 'sell_your_car'" do
    it "should be successful" do
      get 'sell_your_car'
      response.should be_success
    end
  end

  describe "GET 'load_models'" do
    it "should be successful" do
      get 'load_models', :make_id => 1
      response.should be_success
    end
  end

  describe "GET 'load_model_variants'" do
    it "should be successful" do
      get 'load_model_variants', :model_id => 1
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET find_car" do
    it "should be successful" do
      xhr :post, 'find_car', :form => { :first => "Joerg", :last => "Diejk", :phone => "123", :email => "me@spam.com", :criteria => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end
  
  describe "GET used_vehicle_enquiry" do
    it "should be successful" do
      xhr :post, 'used_vehicle_enquiry', :form => { :first => "Joerg", :last => "Diek", :phone => "123", :email => "me@spam.com", :vehicle => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end

  describe "GET new_vehicle_enquiry" do
    it "should be successful" do
      xhr :post, 'new_vehicle_enquiry', :form => { :first => "Joerg", :last => "Diek", :phone => "123", :email => "me@spam.com", :vehicle => "My car", :branch => "N1" }
      response.should be_success
      assigns[:success].should == true
    end
  end

  describe "GET callback" do
    it "should be successful" do

      @branch = Branch.create!( :name => 'test' )
      @salesperson = Salesperson.create!( :name => 'test', :phone => '0824477057', :email => 'mauricio@gmail.com', :job_title => "Salesperson", :sms_contact_me => true )
      @assignment = Assignment.create!( :branch => @branch, :salesperson => @salesperson )

      xhr :post, 'callback', :form => { :first => "Joerg", :last => "Diek", :phone => "123", :vehicle => "My car", :branch_id => @branch.id }
      response.should be_success
      assigns[:success].should == true
    end
  end
  
end
