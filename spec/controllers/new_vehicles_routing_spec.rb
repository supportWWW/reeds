require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehiclesController do
  describe "route generation" do

    it "should map { :controller => 'new_vehicles', :action => 'index' } to /new_vehicles" do
      route_for(:controller => "new_vehicles", :action => "index").should == "/new_vehicles"
    end
  
    it "should map { :controller => 'new_vehicles', :action => 'new' } to /new_vehicles/new" do
      route_for(:controller => "new_vehicles", :action => "new").should == "/new_vehicles/new"
    end
  
    it "should map { :controller => 'new_vehicles', :action => 'show', :id => 1 } to /new_vehicles/1" do
      route_for(:controller => "new_vehicles", :action => "show", :id => 1).should == "/new_vehicles/1"
    end
  
    it "should map { :controller => 'new_vehicles', :action => 'edit', :id => 1 } to /new_vehicles/1/edit" do
      route_for(:controller => "new_vehicles", :action => "edit", :id => 1).should == "/new_vehicles/1/edit"
    end
  
    it "should map { :controller => 'new_vehicles', :action => 'update', :id => 1} to /new_vehicles/1" do
      route_for(:controller => "new_vehicles", :action => "update", :id => 1).should == "/new_vehicles/1"
    end
  
    it "should map { :controller => 'new_vehicles', :action => 'destroy', :id => 1} to /new_vehicles/1" do
      route_for(:controller => "new_vehicles", :action => "destroy", :id => 1).should == "/new_vehicles/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'new_vehicles', action => 'index' } from GET /new_vehicles" do
      params_from(:get, "/new_vehicles").should == {:controller => "new_vehicles", :action => "index"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'new' } from GET /new_vehicles/new" do
      params_from(:get, "/new_vehicles/new").should == {:controller => "new_vehicles", :action => "new"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'create' } from POST /new_vehicles" do
      params_from(:post, "/new_vehicles").should == {:controller => "new_vehicles", :action => "create"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'show', id => '1' } from GET /new_vehicles/1" do
      params_from(:get, "/new_vehicles/1").should == {:controller => "new_vehicles", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'edit', id => '1' } from GET /new_vehicles/1;edit" do
      params_from(:get, "/new_vehicles/1/edit").should == {:controller => "new_vehicles", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'update', id => '1' } from PUT /new_vehicles/1" do
      params_from(:put, "/new_vehicles/1").should == {:controller => "new_vehicles", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'new_vehicles', action => 'destroy', id => '1' } from DELETE /new_vehicles/1" do
      params_from(:delete, "/new_vehicles/1").should == {:controller => "new_vehicles", :action => "destroy", :id => "1"}
    end
  end
end
