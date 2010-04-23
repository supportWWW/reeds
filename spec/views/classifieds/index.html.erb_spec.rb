require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include SearchHelper

describe "/classifieds/index.html.erb" do
  
  it "should render search form" do
    render "/classifieds/index.html.erb"
  end
end

