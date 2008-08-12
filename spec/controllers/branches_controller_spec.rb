require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BranchesController do
  
  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /branches" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:find).and_return([@branch])
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
  
    it "should find all branches" do
      Branch.should_receive(:find).with(:all, :order => 'name asc').and_return([@branch])
      do_get
    end
  
    it "should assign the found branches for the view" do
      do_get
      assigns[:branches].should == [@branch]
    end
  end

  describe "handling GET /branches.xml" do

    before(:each) do
      @branches = mock("Array of Branches", :to_xml => "XML")
      Branch.stub!(:find).and_return(@branches)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all branches" do
      Branch.should_receive(:find).with(:all, :order => 'name asc').and_return(@branches)
      do_get
    end
  
    it "should render the found branches as xml" do
      @branches.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /branches/1" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:find).and_return(@branch)
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
  
    it "should find the branch requested" do
      Branch.should_receive(:find).with("1", :include => :assignments).and_return(@branch)
      do_get
    end
  
    it "should assign the found branch for the view" do
      do_get
      assigns[:branch].should equal(@branch)
    end
  end

  describe "handling GET /branches/1.xml" do

    before(:each) do
      @branch = mock_model(Branch, :to_xml => "XML")
      Branch.stub!(:find).and_return(@branch)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the branch requested" do
      Branch.should_receive(:find).with("1", :include => :assignments ).and_return(@branch)
      do_get
    end
  
    it "should render the found branch as xml" do
      @branch.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /branches/new" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:new).and_return(@branch)
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
  
    it "should create an new branch" do
      Branch.should_receive(:new).and_return(@branch)
      do_get
    end
  
    it "should not save the new branch" do
      @branch.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new branch for the view" do
      do_get
      assigns[:branch].should equal(@branch)
    end
  end

  describe "handling GET /branches/1/edit" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:find).and_return(@branch)
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
  
    it "should find the branch requested" do
      Branch.should_receive(:find).and_return(@branch)
      do_get
    end
  
    it "should assign the found Branch for the view" do
      do_get
      assigns[:branch].should equal(@branch)
    end
  end

  describe "handling POST /branches" do

    before(:each) do
      @branch = mock_model(Branch, :to_param => "1")
      Branch.stub!(:new).and_return(@branch)
    end
    
    describe "with successful save" do
  
      def do_post
        @branch.should_receive(:save).and_return(true)
        post :create, :branch => {}
      end
  
      it "should create a new branch" do
        Branch.should_receive(:new).with({}).and_return(@branch)
        do_post
      end

      it "should redirect to the new branch" do
        do_post
        response.should redirect_to(branch_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @branch.should_receive(:save).and_return(false)
        post :create, :branch => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /branches/1" do

    before(:each) do
      @branch = mock_model(Branch, :to_param => "1")
      Branch.stub!(:find).and_return(@branch)
    end
    
    describe "with successful update" do

      def do_put
        @branch.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the branch requested" do
        Branch.should_receive(:find).with("1").and_return(@branch)
        do_put
      end

      it "should update the found branch" do
        do_put
        assigns(:branch).should equal(@branch)
      end

      it "should assign the found branch for the view" do
        do_put
        assigns(:branch).should equal(@branch)
      end

      it "should redirect to the branch" do
        do_put
        response.should redirect_to(branch_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @branch.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /branches/1" do

    before(:each) do
      @branch = mock_model(Branch, :destroy => true)
      Branch.stub!(:find).and_return(@branch)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the branch requested" do
      Branch.should_receive(:find).with("1").and_return(@branch)
      do_delete
    end
  
    it "should call destroy on the found branch" do
      @branch.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the branches list" do
      do_delete
      response.should redirect_to(admin_branches_path)
    end
  end
  
  describe 'handling DELETE /branches/1/remove_assignment/2' do
    
    before :each do
      @branch = mock_model( Branch, :id => 1 )
      @assignment = mock_model( Assignment, :branch_id => 1, :destroy => true )
      @assignment.stub!( :branch ).and_return( @branch )
      @salesperson = mock_model( Salesperson )
      Salesperson.stub!( :find_not_in_branch ).and_return( [@salesperson] )
      Assignment.stub!( :find_by_branch_and_salesperson ).and_return( @assignment )
    end
    
    def do_xhr
      xhr :delete, :remove_assignment, :id => '2', :branch_id => '1'
    end
    
    it 'Should find the assignment, remove it and find the salespeople not in that branch' do
      Assignment.should_receive( :find_by_branch_and_salesperson ).with( '1', '2' ).and_return( @assignment )
      @assignment.should_receive( :branch )
      @assignment.should_receive( :destroy )
      Salesperson.should_receive( :find_not_in_branch ).with( 1 ).and_return( [ @salesperson ]  )
      do_xhr
    end
    
    it 'Should assign the correct variables' do
      do_xhr
      assigns[:branch].should == @branch
      assigns[:assignment].should == @assignment
      assigns[:salespeople].should == [@salesperson]
    end
    
    it 'Should render the correct template' do
      do_xhr
      response.should render_template( 'branches/remove_assignment' )
    end
    
    it 'Should not render anything when there is no assignment available' do
      Assignment.should_receive( :find_by_branch_and_salesperson ).with( '1', '2' ).and_return( nil )
      do_xhr
      response.should be_success
      response.body.strip.should be_empty
    end
    
  end
  
  
  describe 'handling POST /branches/1/assign/2' do
    
    before :each do
      @assignment = mock_model( Assignment )
      @salesperson = mock_model( Salesperson, :id => '2'  )
      @branch = mock_model( Branch )
      
      @assignments = mock( Array )
      @assignments.stub!( :find ).and_return( nil )
      @assignments.stub!( :create ).and_return( @assignment )
      
      @branch.stub!( :assignments ).and_return( @assignments )
      
      Branch.stub!( :find ).and_return( @branch )
      Salesperson.stub!( :find ).and_return( @salesperson )
    end
    
    def do_xhr
      xhr :post, :assign, :branch_id => '1', :id => '2'
    end
    
    it 'Should find the salesperson and the branch required, and create the assignment' do
      Branch.should_receive( :find ).with( '1' ).and_return( @branch )
      Salesperson.should_receive( :find ).with('2').and_return( @salesperson )
      @assignments.should_receive( :create ).with( :salesperson_id => '2' ).and_return( @assignment )
      do_xhr
    end
    
    it 'Should render the correct assign.js.rjs template' do
      do_xhr
      response.should render_template( 'branches/assign' )
    end
    
    it 'Should assign the correct variables' do
      do_xhr
      assigns[:branch].should == @branch
      assigns[:salesperson].should == @salesperson
      assigns[:assignment].should == @assignment
    end
    
    it 'Should not render the template when there an assignment for that user' do
      @assignments.should_receive( :find ).and_return( [ @assignment ] )
      @assignments.should_not_receive( :create )
      do_xhr
      response.should be_success
      response.body.strip.should be_empty
    end
    
  end
  
end
