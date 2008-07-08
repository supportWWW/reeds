require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelRangesController do
  describe "route generation" do

    it "should map { :controller => 'model_ranges', :action => 'index' } to /model_ranges" do
      route_for(:controller => "model_ranges", :action => "index").should == "/model_ranges"
    end
  
    it "should map { :controller => 'model_ranges', :action => 'new' } to /model_ranges/new" do
      route_for(:controller => "model_ranges", :action => "new").should == "/model_ranges/new"
    end
  
    it "should map { :controller => 'model_ranges', :action => 'show', :id => 1 } to /model_ranges/1" do
      route_for(:controller => "model_ranges", :action => "show", :id => 1).should == "/model_ranges/1"
    end
  
    it "should map { :controller => 'model_ranges', :action => 'edit', :id => 1 } to /model_ranges/1/edit" do
      route_for(:controller => "model_ranges", :action => "edit", :id => 1).should == "/model_ranges/1/edit"
    end
  
    it "should map { :controller => 'model_ranges', :action => 'update', :id => 1} to /model_ranges/1" do
      route_for(:controller => "model_ranges", :action => "update", :id => 1).should == "/model_ranges/1"
    end
  
    it "should map { :controller => 'model_ranges', :action => 'destroy', :id => 1} to /model_ranges/1" do
      route_for(:controller => "model_ranges", :action => "destroy", :id => 1).should == "/model_ranges/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'model_ranges', action => 'index' } from GET /model_ranges" do
      params_from(:get, "/model_ranges").should == {:controller => "model_ranges", :action => "index"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'new' } from GET /model_ranges/new" do
      params_from(:get, "/model_ranges/new").should == {:controller => "model_ranges", :action => "new"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'create' } from POST /model_ranges" do
      params_from(:post, "/model_ranges").should == {:controller => "model_ranges", :action => "create"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'show', id => '1' } from GET /model_ranges/1" do
      params_from(:get, "/model_ranges/1").should == {:controller => "model_ranges", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'edit', id => '1' } from GET /model_ranges/1;edit" do
      params_from(:get, "/model_ranges/1/edit").should == {:controller => "model_ranges", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'update', id => '1' } from PUT /model_ranges/1" do
      params_from(:put, "/model_ranges/1").should == {:controller => "model_ranges", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_ranges', action => 'destroy', id => '1' } from DELETE /model_ranges/1" do
      params_from(:delete, "/model_ranges/1").should == {:controller => "model_ranges", :action => "destroy", :id => "1"}
    end
  end
end
