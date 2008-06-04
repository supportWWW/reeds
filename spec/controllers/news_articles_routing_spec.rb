require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsArticlesController do
  describe "route generation" do

    it "should map { :controller => 'news_articles', :action => 'index' } to /news_articles" do
      route_for(:controller => "news_articles", :action => "index").should == "/news_articles"
    end
  
    it "should map { :controller => 'news_articles', :action => 'new' } to /news_articles/new" do
      route_for(:controller => "news_articles", :action => "new").should == "/news_articles/new"
    end
  
    it "should map { :controller => 'news_articles', :action => 'show', :id => 1 } to /news_articles/1" do
      route_for(:controller => "news_articles", :action => "show", :id => 1).should == "/news_articles/1"
    end
  
    it "should map { :controller => 'news_articles', :action => 'edit', :id => 1 } to /news_articles/1/edit" do
      route_for(:controller => "news_articles", :action => "edit", :id => 1).should == "/news_articles/1/edit"
    end
  
    it "should map { :controller => 'news_articles', :action => 'update', :id => 1} to /news_articles/1" do
      route_for(:controller => "news_articles", :action => "update", :id => 1).should == "/news_articles/1"
    end
  
    it "should map { :controller => 'news_articles', :action => 'destroy', :id => 1} to /news_articles/1" do
      route_for(:controller => "news_articles", :action => "destroy", :id => 1).should == "/news_articles/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'news_articles', action => 'index' } from GET /news_articles" do
      params_from(:get, "/news_articles").should == {:controller => "news_articles", :action => "index"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'new' } from GET /news_articles/new" do
      params_from(:get, "/news_articles/new").should == {:controller => "news_articles", :action => "new"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'create' } from POST /news_articles" do
      params_from(:post, "/news_articles").should == {:controller => "news_articles", :action => "create"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'show', id => '1' } from GET /news_articles/1" do
      params_from(:get, "/news_articles/1").should == {:controller => "news_articles", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'edit', id => '1' } from GET /news_articles/1;edit" do
      params_from(:get, "/news_articles/1/edit").should == {:controller => "news_articles", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'update', id => '1' } from PUT /news_articles/1" do
      params_from(:put, "/news_articles/1").should == {:controller => "news_articles", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_articles', action => 'destroy', id => '1' } from DELETE /news_articles/1" do
      params_from(:delete, "/news_articles/1").should == {:controller => "news_articles", :action => "destroy", :id => "1"}
    end
  end
end
