require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/referrals/show.html.erb" do
  include ReferralsHelper
  
  before(:each) do
    @referral = mock_model(Referral)
    @referral.stub!(:name).and_return("MyName")
    @referral.stub!(:source).and_return("MyString")
    @referral.stub!(:visits_count).and_return( 10 )
    @referral.stub!(:description).and_return("MyText")

    assigns[:referral] = @referral
  end

  it "should render attributes in <p>" do
    render "/referrals/show.html.erb"
    response.should have_text(/MyName/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

