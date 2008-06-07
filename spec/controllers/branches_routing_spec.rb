require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BranchesController do
  describe "route generation" do

    it "should map { :controller => 'branches', :action => 'index' } to /branches" do
      route_for(:controller => "branches", :action => "index").should == "/branches"
    end
  
    it "should map { :controller => 'branches', :action => 'new' } to /branches/new" do
      route_for(:controller => "branches", :action => "new").should == "/branches/new"
    end
  
    it "should map { :controller => 'branches', :action => 'show', :id => 1 } to /branches/1" do
      route_for(:controller => "branches", :action => "show", :id => 1).should == "/branches/1"
    end
  
    it "should map { :controller => 'branches', :action => 'edit', :id => 1 } to /branches/1/edit" do
      route_for(:controller => "branches", :action => "edit", :id => 1).should == "/branches/1/edit"
    end
  
    it "should map { :controller => 'branches', :action => 'update', :id => 1} to /branches/1" do
      route_for(:controller => "branches", :action => "update", :id => 1).should == "/branches/1"
    end
  
    it "should map { :controller => 'branches', :action => 'destroy', :id => 1} to /branches/1" do
      route_for(:controller => "branches", :action => "destroy", :id => 1).should == "/branches/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'branches', action => 'index' } from GET /branches" do
      params_from(:get, "/branches").should == {:controller => "branches", :action => "index"}
    end
  
    it "should generate params { :controller => 'branches', action => 'new' } from GET /branches/new" do
      params_from(:get, "/branches/new").should == {:controller => "branches", :action => "new"}
    end
  
    it "should generate params { :controller => 'branches', action => 'create' } from POST /branches" do
      params_from(:post, "/branches").should == {:controller => "branches", :action => "create"}
    end
  
    it "should generate params { :controller => 'branches', action => 'show', id => '1' } from GET /branches/1" do
      params_from(:get, "/branches/1").should == {:controller => "branches", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'branches', action => 'edit', id => '1' } from GET /branches/1;edit" do
      params_from(:get, "/branches/1/edit").should == {:controller => "branches", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'branches', action => 'update', id => '1' } from PUT /branches/1" do
      params_from(:put, "/branches/1").should == {:controller => "branches", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'branches', action => 'destroy', id => '1' } from DELETE /branches/1" do
      params_from(:delete, "/branches/1").should == {:controller => "branches", :action => "destroy", :id => "1"}
    end
  end
end
