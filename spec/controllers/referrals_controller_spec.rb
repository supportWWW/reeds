require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReferralsController do
  
  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /referrals" do

    before(:each) do
      @referral = mock_model(Referral)
      Referral.stub!(:find).and_return([@referral])
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
  
    it "should find all referrals" do
      Referral.should_receive(:paginate).and_return([@referral])
      do_get
    end
  
    it "should assign the found referrals for the view" do
      do_get
      assigns[:referrals].should == [@referral]
    end
  end

  describe "handling GET /referrals.xml" do

    before(:each) do
      @referrals = mock("Array of Referrals", :to_xml => "XML")
      Referral.stub!(:paginate).and_return(@referrals)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all referrals" do
      Referral.should_receive(:paginate).and_return(@referrals)
      do_get
    end
  
    it "should render the found referrals as xml" do
      @referrals.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /referrals/1" do

    before(:each) do
      @referral = mock_model(Referral)
      Referral.stub!(:find).and_return(@referral)
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
  
    it "should find the referral requested" do
      Referral.should_receive(:find).with("1").and_return(@referral)
      do_get
    end
  
    it "should assign the found referral for the view" do
      do_get
      assigns[:referral].should equal(@referral)
    end
  end

  describe "handling GET /referrals/1.xml" do

    before(:each) do
      @referral = mock_model(Referral, :to_xml => "XML")
      Referral.stub!(:find).and_return(@referral)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the referral requested" do
      Referral.should_receive(:find).with("1").and_return(@referral)
      do_get
    end
  
    it "should render the found referral as xml" do
      @referral.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /referrals/new" do

    before(:each) do
      @referral = mock_model(Referral)
      Referral.stub!(:new).and_return(@referral)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new referral" do
      Referral.should_receive(:new).and_return(@referral)
      do_get
    end
  
    it "should not save the new referral" do
      @referral.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new referral for the view" do
      do_get
      assigns[:referral].should equal(@referral)
    end
  end

  describe "handling GET /referrals/1/edit" do

    before(:each) do
      @referral = mock_model(Referral)
      Referral.stub!(:find).and_return(@referral)
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
  
    it "should find the referral requested" do
      Referral.should_receive(:find).and_return(@referral)
      do_get
    end
  
    it "should assign the found Referral for the view" do
      do_get
      assigns[:referral].should equal(@referral)
    end
  end

  describe "handling POST /referrals" do

    before(:each) do
      @referral = mock_model(Referral, :to_param => "1")
      Referral.stub!(:new).and_return(@referral)
    end
    
    describe "with successful save" do
  
      def do_post
        @referral.should_receive(:save).and_return(true)
        post :create, :referral => {}
      end
  
      it "should create a new referral" do
        Referral.should_receive(:new).with({}).and_return(@referral)
        do_post
      end

      it "should redirect to the new referral" do
        do_post
        response.should redirect_to(referral_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @referral.should_receive(:save).and_return(false)
        post :create, :referral => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /referrals/1" do

    before(:each) do
      @referral = mock_model(Referral, :to_param => "1")
      Referral.stub!(:find).and_return(@referral)
    end
    
    describe "with successful update" do

      def do_put
        @referral.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the referral requested" do
        Referral.should_receive(:find).with("1").and_return(@referral)
        do_put
      end

      it "should update the found referral" do
        do_put
        assigns(:referral).should equal(@referral)
      end

      it "should assign the found referral for the view" do
        do_put
        assigns(:referral).should equal(@referral)
      end

      it "should redirect to the referral" do
        do_put
        response.should redirect_to(referral_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @referral.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /referrals/1" do

    before(:each) do
      @referral = mock_model(Referral, :destroy => true)
      Referral.stub!(:find).and_return(@referral)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the referral requested" do
      Referral.should_receive(:find).with("1").and_return(@referral)
      do_delete
    end
  
    it "should call destroy on the found referral" do
      @referral.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the referrals list" do
      do_delete
      response.should redirect_to(admin_referrals_path)
    end
  end
  
  describe 'handling GET /referrals/1/visit' do
    
    before :each do
      @referral = mock_model( Referral, :redirect_to => '/', :id => 1 )
      @referral.stub!( :visits ).and_return( @referral )
      @referral.stub!( :create ).and_return( @referral )
      Referral.stub!( :find ).and_return( @referral )
    end
    
    def do_visit
      get :visit, :id => '1'
    end
    
    it 'Should create a new visit' do
      @referral.should_receive( :create )
      do_visit
    end
    
    it 'Should add the current referral id to the user session' do
      do_visit
      session[:visits].should == '1'
    end
    
    it 'Should not create a new visit if the id is already on the sessions visits' do
      session[:visits]= "2,3,1"
      @referral.should_not_receive( :create )
      do_visit
    end
    
    it 'Should create a new visit and add the id to the sessions visits' do
      session[:visits]= "2,3"
      do_visit
      session[:visits].should == "2,3,1"
    end    
    
  end
  
end
