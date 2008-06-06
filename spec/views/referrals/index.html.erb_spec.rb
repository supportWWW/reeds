require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/referrals/index.html.erb" do
  include ReferralsHelper
  
  before(:each) do
    referral_98 = mock_model(Referral)
    referral_98.should_receive(:source).and_return("MyString")
    referral_98.should_receive(:description).and_return("MyText")
    referral_99 = mock_model(Referral)
    referral_99.should_receive(:source).and_return("MyString")
    referral_99.should_receive(:description).and_return("MyText")

    assigns[:referrals] = [referral_98, referral_99]
  end

  it "should render list of referrals" do
    render "/referrals/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

