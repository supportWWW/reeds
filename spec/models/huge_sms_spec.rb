require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HugeSms do

  it "should create XML" do
    xml = HugeSms.create_xml("+27824477057", "Testing SMS", "joerg", "password")
    xml.should have_tag("SMS_SEND[to=?]", "+27824477057")
  end
  
  it "should successfully deliver" do
    HugeSms.deliver("+27824477057", "Testing SMS").should == true
  end
end
