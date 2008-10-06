require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/importer/import_mm" do
  before(:each) do
    render 'admin/importer/import_mm'
  end
  
  it "should show heading" do
    response.should have_tag('h2', %r[Import Mead &amp; McGrouther])
  end
end
