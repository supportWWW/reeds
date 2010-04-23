require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewslettersController do

  #Delete these examples and add some real ones
  it "should use NewslettersController" do
    controller.should be_an_instance_of(NewslettersController)
  end


  describe "GET 'subscribe'" do
    it "should be successful" do
      get 'subscribe'
      response.should be_success
    end
  end

  describe "GET 'unsubscribed'" do
    it "should be successful" do
      get 'unsubscribed'
      response.should be_success
    end
  end

  describe "GET 'confirmation'" do
    it "should be successful" do
      get 'confirmation'
      response.should be_success
    end
  end
end
