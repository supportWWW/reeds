require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReferralsController do
  
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
