require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/referrals/index.html.erb" do
  include Admin::ReferralsHelper
  
  before(:each) do
    referral_98 = mock_model(Referral)
    referral_98.should_receive(:name).and_return("MyName")
    referral_98.should_receive(:source).and_return("MyString")
    referral_98.should_receive(:visits).and_return(Visit.all)
    
    referral_99 = mock_model(Referral)
    referral_99.should_receive(:name).and_return("MyName")
    referral_99.should_receive(:source).and_return("MyString")
    referral_99.should_receive(:visits).and_return(Visit.all)

    assigns[:referrals] = [referral_98, referral_99]
    assigns[:referrals].should_receive(:total_pages).twice.and_return( 1 )
  end

  it "should render list of referrals" do
    render "/admin/referrals/index.html.erb"
    response.should have_tag("tr>td", "MyName", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

