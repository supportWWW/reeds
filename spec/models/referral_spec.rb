require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Referral do
  before(:each) do
    @referral = Referral.new
  end

  it "should be valid" do
    @referral.should be_valid
  end
end
