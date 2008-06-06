require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReferralsController do
  describe "route generation" do

    it "should map { :controller => 'referrals', :action => 'index' } to /referrals" do
      route_for(:controller => "referrals", :action => "index").should == "/referrals"
    end
  
    it "should map { :controller => 'referrals', :action => 'new' } to /referrals/new" do
      route_for(:controller => "referrals", :action => "new").should == "/referrals/new"
    end
  
    it "should map { :controller => 'referrals', :action => 'show', :id => 1 } to /referrals/1" do
      route_for(:controller => "referrals", :action => "show", :id => 1).should == "/referrals/1"
    end
  
    it "should map { :controller => 'referrals', :action => 'edit', :id => 1 } to /referrals/1/edit" do
      route_for(:controller => "referrals", :action => "edit", :id => 1).should == "/referrals/1/edit"
    end
  
    it "should map { :controller => 'referrals', :action => 'update', :id => 1} to /referrals/1" do
      route_for(:controller => "referrals", :action => "update", :id => 1).should == "/referrals/1"
    end
  
    it "should map { :controller => 'referrals', :action => 'destroy', :id => 1} to /referrals/1" do
      route_for(:controller => "referrals", :action => "destroy", :id => 1).should == "/referrals/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'referrals', action => 'index' } from GET /referrals" do
      params_from(:get, "/referrals").should == {:controller => "referrals", :action => "index"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'new' } from GET /referrals/new" do
      params_from(:get, "/referrals/new").should == {:controller => "referrals", :action => "new"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'create' } from POST /referrals" do
      params_from(:post, "/referrals").should == {:controller => "referrals", :action => "create"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'show', id => '1' } from GET /referrals/1" do
      params_from(:get, "/referrals/1").should == {:controller => "referrals", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'edit', id => '1' } from GET /referrals/1;edit" do
      params_from(:get, "/referrals/1/edit").should == {:controller => "referrals", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'update', id => '1' } from PUT /referrals/1" do
      params_from(:put, "/referrals/1").should == {:controller => "referrals", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'referrals', action => 'destroy', id => '1' } from DELETE /referrals/1" do
      params_from(:delete, "/referrals/1").should == {:controller => "referrals", :action => "destroy", :id => "1"}
    end
  end
end
