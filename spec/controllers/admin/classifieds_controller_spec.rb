require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ClassifiedsController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /classifieds/expired" do

    before(:each) do
      @classified = mock_model(Classified)
      Cyberstock.stub!(:find).and_return([@classified])
    end
  
    def do_get
      get :expired
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('expired')
    end
  
    it "should find all expired cyberstock" do
      Cyberstock.should_receive(:find).with(:all).and_return([@classified])
      do_get
    end
  
    it "should assign the found classifieds for the view" do
      do_get
      assigns[:classifieds].should == [@classified]
    end
  end

  describe "handling GET /classifieds/cyberstock" do

    before(:each) do
      @classified = mock_model(Classified)
      Cyberstock.stub!(:live).and_return([@classified])
    end
  
    def do_get
      get :cyberstock
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('cyberstock')
    end
  
    it "should find all cyberstock" do
      Cyberstock.should_receive(:live).and_return([@classified])
      do_get
    end
  
    it "should assign the found classifieds for the view" do
      do_get
      assigns[:classifieds].should == [@classified]
    end
  end

  describe "handling GET /classifieds/with_photo" do

    before(:each) do
      @classified = Classified.new
      @classified.stub!(:has_all_images?).and_return(true)
      Classified.stub!(:find).and_return([@classified])
    end
  
    def do_get
      get :with_photo
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('with_photo')
    end
  
    it "should find all classifieds" do
      Classified.should_receive(:find).with(:all).and_return([@classified])
      do_get
    end
  
    it "should assign the found classifieds for the view" do
      do_get
      assigns[:classifieds].should == [@classified]
    end
  end

  describe "handling GET /classifieds/no_photo" do

    before(:each) do
      @classified = Classified.new
      Classified.stub!(:find).and_return([@classified])
    end
  
    def do_get
      get :no_photo
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('no_photo')
    end
  
    it "should find all classifieds" do
      Classified.should_receive(:find).with(:all).and_return([@classified])
      do_get
    end
  
    it "should assign the found classifieds for the view" do
      do_get
      assigns[:classifieds].should == [@classified]
    end
  end

  describe "handling GET /classifieds/1/edit" do

    before(:each) do
      @classified = mock_model(Classified)
      Classified.stub!(:find).and_return(@classified)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the classified requested" do
      Classified.should_receive(:find).and_return(@classified)
      do_get
    end
  
    it "should assign the found Classified for the view" do
      do_get
      assigns[:classified].should equal(@classified)
    end
  end

  describe "handling PUT /classifieds/1" do

    before(:each) do
      @classified = mock_model(Classified, :to_param => "1")
      Classified.stub!(:find).and_return(@classified)
    end
    
    describe "with successful update" do

      def do_put
        @classified.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the classified requested" do
        Classified.should_receive(:find).with("1").and_return(@classified)
        do_put
      end

      it "should update the found classified" do
        do_put
        assigns(:classified).should equal(@classified)
      end

      it "should assign the found classified for the view" do
        do_put
        assigns(:classified).should equal(@classified)
      end

      it "should redirect to the classified" do
        do_put
        response.should redirect_to(cyberstock_admin_classifieds_path)
      end

    end
    
    describe "with failed update" do

      def do_put
        @classified.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end


    describe "handling DELETE /categories/1" do

      before(:each) do
        @classified = mock_model(Classified, :destroy => true)
        Classified.stub!(:find).and_return(@classified)
      end

      def do_delete
        delete :destroy, :id => "1"
      end

      it "should find the category requested" do
        Classified.should_receive(:find).with("1").and_return(@classified)
        do_delete
      end

      it "should call destroy on the found category" do
        @classified.should_receive(:destroy)
        do_delete
      end

      it "should redirect to the categories list" do
        do_delete
        response.should redirect_to(cyberstock_admin_classifieds_path)
      end
    end
  end

end
