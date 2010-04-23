require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do
  
  describe "handling GET /events" do

    before(:each) do
      @event = mock_model(Event)
      Event.stub!(:find).and_return([@event])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all events" do
      Event.should_receive(:find).and_return([@event])
      do_get
    end
  
    it "should assign the found events for the view" do
      do_get
      assigns[:events].should == [@event]
    end
  end

  describe "handling GET /events.xml" do

    before(:each) do
      @events = mock("Array of Events", :to_xml => "XML")
      Event.stub!(:paginate).and_return(@events)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all events" do
      Event.should_receive(:paginate).and_return(@events)
      do_get
    end
  
    it "should render the found events as xml" do
      @events.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /events/1" do

    before(:each) do
      @event = mock_model(Event)
      Event.stub!(:find).and_return(@event)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the event requested" do
      Event.should_receive(:find).with("1").and_return(@event)
      do_get
    end
  
    it "should assign the found event for the view" do
      do_get
      assigns[:event].should equal(@event)
    end
  end

  describe "handling GET /events/1.xml" do

    before(:each) do
      @event = mock_model(Event, :to_xml => "XML")
      Event.stub!(:find).and_return(@event)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the event requested" do
      Event.should_receive(:find).with("1").and_return(@event)
      do_get
    end
  
    it "should render the found event as xml" do
      @event.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /events/1/image?image_id=1" do

    before(:each) do
      @event = mock_model(Event)
      Event.stub!(:find).and_return(@event)

      @image = mock_model(EventImage)
      EventImage.stub!(:find).and_return(@image)
    end
  
    def do_get
      get :image, :id => "1", :image_id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('image')
    end
  
    it "should find the event requested" do
      Event.should_receive(:find).with("1").and_return(@event)
      do_get
    end
  
    it "should assign the found event for the view" do
      do_get
      assigns[:event].should equal(@event)
    end
  end

end
