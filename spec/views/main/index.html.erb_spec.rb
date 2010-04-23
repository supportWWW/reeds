require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include SearchHelper

describe "/main/index" do
  before(:each) do
    render 'main/index'
  end
  
end
