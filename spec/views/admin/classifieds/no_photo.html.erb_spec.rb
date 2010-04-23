require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/classifieds/no_photo.html.erb" do
  include Admin::ClassifiedsHelper
  
  it "should render list of classifieds" do
    render "/admin/classifieds/no_photo.html.erb"
  end
end

