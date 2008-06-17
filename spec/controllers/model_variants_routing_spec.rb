require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelVariantsController do
  describe "route generation" do

    it "should map { :controller => 'model_variants', :action => 'index' } to /model_variants" do
      route_for(:controller => "model_variants", :action => "index").should == "/model_variants"
    end
  
    it "should map { :controller => 'model_variants', :action => 'new' } to /model_variants/new" do
      route_for(:controller => "model_variants", :action => "new").should == "/model_variants/new"
    end
  
    it "should map { :controller => 'model_variants', :action => 'show', :id => 1 } to /model_variants/1" do
      route_for(:controller => "model_variants", :action => "show", :id => 1).should == "/model_variants/1"
    end
  
    it "should map { :controller => 'model_variants', :action => 'edit', :id => 1 } to /model_variants/1/edit" do
      route_for(:controller => "model_variants", :action => "edit", :id => 1).should == "/model_variants/1/edit"
    end
  
    it "should map { :controller => 'model_variants', :action => 'update', :id => 1} to /model_variants/1" do
      route_for(:controller => "model_variants", :action => "update", :id => 1).should == "/model_variants/1"
    end
  
    it "should map { :controller => 'model_variants', :action => 'destroy', :id => 1} to /model_variants/1" do
      route_for(:controller => "model_variants", :action => "destroy", :id => 1).should == "/model_variants/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'model_variants', action => 'index' } from GET /model_variants" do
      params_from(:get, "/model_variants").should == {:controller => "model_variants", :action => "index"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'new' } from GET /model_variants/new" do
      params_from(:get, "/model_variants/new").should == {:controller => "model_variants", :action => "new"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'create' } from POST /model_variants" do
      params_from(:post, "/model_variants").should == {:controller => "model_variants", :action => "create"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'show', id => '1' } from GET /model_variants/1" do
      params_from(:get, "/model_variants/1").should == {:controller => "model_variants", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'edit', id => '1' } from GET /model_variants/1;edit" do
      params_from(:get, "/model_variants/1/edit").should == {:controller => "model_variants", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'update', id => '1' } from PUT /model_variants/1" do
      params_from(:put, "/model_variants/1").should == {:controller => "model_variants", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'model_variants', action => 'destroy', id => '1' } from DELETE /model_variants/1" do
      params_from(:delete, "/model_variants/1").should == {:controller => "model_variants", :action => "destroy", :id => "1"}
    end
  end
end
