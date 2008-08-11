require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/importer/import_mm" do
  before(:each) do
    render 'importer/import_mm'
  end
  
  it "should show heading" do
    response.should have_tag('h1', %r[Import Mead &amp; McGrouther list])
  end
end
