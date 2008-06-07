require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SalespeopleController do
  describe "route generation" do

    it "should map { :controller => 'salespeople', :action => 'index' } to /salespeople" do
      route_for(:controller => "salespeople", :action => "index").should == "/salespeople"
    end
  
    it "should map { :controller => 'salespeople', :action => 'new' } to /salespeople/new" do
      route_for(:controller => "salespeople", :action => "new").should == "/salespeople/new"
    end
  
    it "should map { :controller => 'salespeople', :action => 'show', :id => 1 } to /salespeople/1" do
      route_for(:controller => "salespeople", :action => "show", :id => 1).should == "/salespeople/1"
    end
  
    it "should map { :controller => 'salespeople', :action => 'edit', :id => 1 } to /salespeople/1/edit" do
      route_for(:controller => "salespeople", :action => "edit", :id => 1).should == "/salespeople/1/edit"
    end
  
    it "should map { :controller => 'salespeople', :action => 'update', :id => 1} to /salespeople/1" do
      route_for(:controller => "salespeople", :action => "update", :id => 1).should == "/salespeople/1"
    end
  
    it "should map { :controller => 'salespeople', :action => 'destroy', :id => 1} to /salespeople/1" do
      route_for(:controller => "salespeople", :action => "destroy", :id => 1).should == "/salespeople/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'salespeople', action => 'index' } from GET /salespeople" do
      params_from(:get, "/salespeople").should == {:controller => "salespeople", :action => "index"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'new' } from GET /salespeople/new" do
      params_from(:get, "/salespeople/new").should == {:controller => "salespeople", :action => "new"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'create' } from POST /salespeople" do
      params_from(:post, "/salespeople").should == {:controller => "salespeople", :action => "create"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'show', id => '1' } from GET /salespeople/1" do
      params_from(:get, "/salespeople/1").should == {:controller => "salespeople", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'edit', id => '1' } from GET /salespeople/1;edit" do
      params_from(:get, "/salespeople/1/edit").should == {:controller => "salespeople", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'update', id => '1' } from PUT /salespeople/1" do
      params_from(:put, "/salespeople/1").should == {:controller => "salespeople", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'salespeople', action => 'destroy', id => '1' } from DELETE /salespeople/1" do
      params_from(:delete, "/salespeople/1").should == {:controller => "salespeople", :action => "destroy", :id => "1"}
    end
  end
end
