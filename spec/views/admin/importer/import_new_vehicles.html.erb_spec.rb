require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/importer/import_new_vehicles" do
  before(:each) do
    render 'admin/importer/import_new_vehicles'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should show heading" do
    response.should have_tag('h2', %r[Import New Vehicles &amp; Trucks])
  end
end
