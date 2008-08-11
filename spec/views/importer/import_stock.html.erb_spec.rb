require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/importer/import_stock" do
  before(:each) do
    render 'importer/import_stock'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should show heading" do
    response.should have_tag('h1', %r[Import Stock List])
  end
end
