require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/importer/import_mm" do
  before(:each) do
    render 'importer/import_mm'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/importer/import_mm])
  end
end
