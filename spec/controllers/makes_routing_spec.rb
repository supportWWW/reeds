require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MakesController do
  describe "route generation" do

    it "should map { :controller => 'makes', :action => 'index' } to /makes" do
      route_for(:controller => "makes", :action => "index").should == "/makes"
    end
  
    it "should map { :controller => 'makes', :action => 'new' } to /makes/new" do
      route_for(:controller => "makes", :action => "new").should == "/makes/new"
    end
  
    it "should map { :controller => 'makes', :action => 'show', :id => 1 } to /makes/1" do
      route_for(:controller => "makes", :action => "show", :id => 1).should == "/makes/1"
    end
  
    it "should map { :controller => 'makes', :action => 'edit', :id => 1 } to /makes/1/edit" do
      route_for(:controller => "makes", :action => "edit", :id => 1).should == "/makes/1/edit"
    end
  
    it "should map { :controller => 'makes', :action => 'update', :id => 1} to /makes/1" do
      route_for(:controller => "makes", :action => "update", :id => 1).should == "/makes/1"
    end
  
    it "should map { :controller => 'makes', :action => 'destroy', :id => 1} to /makes/1" do
      route_for(:controller => "makes", :action => "destroy", :id => 1).should == "/makes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'makes', action => 'index' } from GET /makes" do
      params_from(:get, "/makes").should == {:controller => "makes", :action => "index"}
    end
  
    it "should generate params { :controller => 'makes', action => 'new' } from GET /makes/new" do
      params_from(:get, "/makes/new").should == {:controller => "makes", :action => "new"}
    end
  
    it "should generate params { :controller => 'makes', action => 'create' } from POST /makes" do
      params_from(:post, "/makes").should == {:controller => "makes", :action => "create"}
    end
  
    it "should generate params { :controller => 'makes', action => 'show', id => '1' } from GET /makes/1" do
      params_from(:get, "/makes/1").should == {:controller => "makes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'makes', action => 'edit', id => '1' } from GET /makes/1;edit" do
      params_from(:get, "/makes/1/edit").should == {:controller => "makes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'makes', action => 'update', id => '1' } from PUT /makes/1" do
      params_from(:put, "/makes/1").should == {:controller => "makes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'makes', action => 'destroy', id => '1' } from DELETE /makes/1" do
      params_from(:delete, "/makes/1").should == {:controller => "makes", :action => "destroy", :id => "1"}
    end
  end
end
