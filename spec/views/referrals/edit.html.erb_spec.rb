require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/referrals/edit.html.erb" do
  include ReferralsHelper
  
  before do
    @referral = mock_model(Referral)
    @referral.stub!(:name).and_return("MyName")
    @referral.stub!(:redirect_to).and_return("MyRedirectTo")
    @referral.stub!(:source).and_return("MyString")
    @referral.stub!(:description).and_return("MyText")
    assigns[:referral] = @referral
  end

  it "should render edit form" do
    render "/referrals/edit.html.erb"
    
    response.should have_tag("form[action=#{referral_path(@referral)}][method=post]") do
      with_tag('input#referral_name[name=?]', "referral[name]")
      with_tag('input#referral_redirect_to[name=?]', "referral[redirect_to]")
      with_tag('input#referral_source[name=?]', "referral[source]")
      with_tag('textarea#referral_description[name=?]', "referral[description]")
    end
  end
end


