require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClassifiedsController do
  describe "route generation" do

    it "should map { :controller => 'classifieds', :action => 'index' } to /classifieds" do
      route_for(:controller => "classifieds", :action => "index").should == "/classifieds"
    end
  
    it "should map { :controller => 'classifieds', :action => 'new' } to /classifieds/new" do
      route_for(:controller => "classifieds", :action => "new").should == "/classifieds/new"
    end
  
    it "should map { :controller => 'classifieds', :action => 'show', :id => 1 } to /classifieds/1" do
      route_for(:controller => "classifieds", :action => "show", :id => 1).should == "/classifieds/1"
    end
  
    it "should map { :controller => 'classifieds', :action => 'edit', :id => 1 } to /classifieds/1/edit" do
      route_for(:controller => "classifieds", :action => "edit", :id => 1).should == "/classifieds/1/edit"
    end
  
    it "should map { :controller => 'classifieds', :action => 'update', :id => 1} to /classifieds/1" do
      route_for(:controller => "classifieds", :action => "update", :id => 1).should == "/classifieds/1"
    end
  
    it "should map { :controller => 'classifieds', :action => 'destroy', :id => 1} to /classifieds/1" do
      route_for(:controller => "classifieds", :action => "destroy", :id => 1).should == "/classifieds/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'classifieds', action => 'index' } from GET /classifieds" do
      params_from(:get, "/classifieds").should == {:controller => "classifieds", :action => "index"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'new' } from GET /classifieds/new" do
      params_from(:get, "/classifieds/new").should == {:controller => "classifieds", :action => "new"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'create' } from POST /classifieds" do
      params_from(:post, "/classifieds").should == {:controller => "classifieds", :action => "create"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'show', id => '1' } from GET /classifieds/1" do
      params_from(:get, "/classifieds/1").should == {:controller => "classifieds", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'edit', id => '1' } from GET /classifieds/1;edit" do
      params_from(:get, "/classifieds/1/edit").should == {:controller => "classifieds", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'update', id => '1' } from PUT /classifieds/1" do
      params_from(:put, "/classifieds/1").should == {:controller => "classifieds", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'classifieds', action => 'destroy', id => '1' } from DELETE /classifieds/1" do
      params_from(:delete, "/classifieds/1").should == {:controller => "classifieds", :action => "destroy", :id => "1"}
    end
  end
end
