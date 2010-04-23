class Admin::ReferralsController < Admin::ApplicationController

  before_filter :load_page, :only => :index
  
  # GET /referrals
  # GET /referrals.xml
  def index
    @referrals = paginate( Referral, :order => 'created_at desc' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referrals }
    end
  end

  # GET /referrals/1
  # GET /referrals/1.xml
  def show
    @referral = Referral.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @referral }
    end
  end

  # GET /referrals/new
  # GET /referrals/new.xml
  def new
    @referral = Referral.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @referral }
    end
  end

  # GET /referrals/1/edit
  def edit
    @referral = Referral.find(params[:id])
  end

  # POST /referrals
  # POST /referrals.xml
  def create
    @referral = Referral.new(params[:referral])

    respond_to do |format|
      if @referral.save
        flash[:notice] = 'Referral was successfully created.'
        format.html { redirect_to(admin_referral_path(@referral)) }
        format.xml  { render :xml => @referral, :status => :created, :location => @referral }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @referral.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /referrals/1
  # PUT /referrals/1.xml
  def update
    @referral = Referral.find(params[:id])

    respond_to do |format|
      if @referral.update_attributes(params[:referral])
        flash[:notice] = 'Referral was successfully updated.'
        format.html { redirect_to(admin_referral_path(@referral)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @referral.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.xml
  def destroy
    @referral = Referral.find(params[:id])
    @referral.destroy

    respond_to do |format|
      format.html { redirect_to(admin_referrals_path) }
      format.xml  { head :ok }
    end
  end
  
  def visit
    @referral = Referral.find(params[:id])
    if session[:visits].blank?
      session[:visits] = @referral.id.to_s
      create_visit
    elsif !(session[:visits].split(',').collect { |v| v.strip }.include?( @referral.id.to_s ))
      create_visit
      session[:visits] += ",#{@referral.id}"
    else
      flash[:debug] = 'User clicked more than once on the same link '
    end
    
    respond_to do |format|
      format.html { redirect_to @referral.redirect_to }
      format.jpeg do |format|
        send_data get_image, :disposition => 'inline', :type => 'image/jpeg'
      end
    end
    
  end
  
  private
  
  def get_image
    IO.read( "#{RAILS_ROOT}/public/images/blank.jpeg" )
  end
  
  def create_visit
    @referral.visits.create( :referer => request.headers['Referer'], :user_agent => request.headers['User-Agent'], :remote_ip => request.remote_ip )
  end
  
end
