require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MenuItemsController do
  describe "route generation" do

    it "should map { :controller => 'menu_items', :action => 'index' } to /menu_items" do
      route_for(:controller => "menu_items", :action => "index").should == "/menu_items"
    end
  
    it "should map { :controller => 'menu_items', :action => 'new' } to /menu_items/new" do
      route_for(:controller => "menu_items", :action => "new").should == "/menu_items/new"
    end
  
    it "should map { :controller => 'menu_items', :action => 'show', :id => 1 } to /menu_items/1" do
      route_for(:controller => "menu_items", :action => "show", :id => 1).should == "/menu_items/1"
    end
  
    it "should map { :controller => 'menu_items', :action => 'edit', :id => 1 } to /menu_items/1/edit" do
      route_for(:controller => "menu_items", :action => "edit", :id => 1).should == "/menu_items/1/edit"
    end
  
    it "should map { :controller => 'menu_items', :action => 'update', :id => 1} to /menu_items/1" do
      route_for(:controller => "menu_items", :action => "update", :id => 1).should == "/menu_items/1"
    end
  
    it "should map { :controller => 'menu_items', :action => 'destroy', :id => 1} to /menu_items/1" do
      route_for(:controller => "menu_items", :action => "destroy", :id => 1).should == "/menu_items/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'menu_items', action => 'index' } from GET /menu_items" do
      params_from(:get, "/menu_items").should == {:controller => "menu_items", :action => "index"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'new' } from GET /menu_items/new" do
      params_from(:get, "/menu_items/new").should == {:controller => "menu_items", :action => "new"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'create' } from POST /menu_items" do
      params_from(:post, "/menu_items").should == {:controller => "menu_items", :action => "create"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'show', id => '1' } from GET /menu_items/1" do
      params_from(:get, "/menu_items/1").should == {:controller => "menu_items", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'edit', id => '1' } from GET /menu_items/1;edit" do
      params_from(:get, "/menu_items/1/edit").should == {:controller => "menu_items", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'update', id => '1' } from PUT /menu_items/1" do
      params_from(:put, "/menu_items/1").should == {:controller => "menu_items", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'menu_items', action => 'destroy', id => '1' } from DELETE /menu_items/1" do
      params_from(:delete, "/menu_items/1").should == {:controller => "menu_items", :action => "destroy", :id => "1"}
    end
  end
end
