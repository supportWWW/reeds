require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/referrals/new.html.erb" do
  include Admin::ReferralsHelper
  
  before(:each) do
    @referral = mock_model(Referral)
    @referral.stub!(:new_record?).and_return(true)
    @referral.stub!(:name).and_return("MyName")
    @referral.stub!(:redirect_to).and_return("MyRedirectTo")
    @referral.stub!(:source).and_return("MyString")
    @referral.stub!(:description).and_return("MyText")
    assigns[:referral] = @referral
  end

  it "should render new form" do
    render "/admin/referrals/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_referrals_path) do
      with_tag("input#referral_name[name=?]", "referral[name]")
      with_tag("input#referral_redirect_to[name=?]", "referral[redirect_to]")
      with_tag("input#referral_source[name=?]", "referral[source]")
      with_tag("textarea#referral_description[name=?]", "referral[description]")
    end
  end
end


