class Admin::SalespeopleController < Admin::ApplicationController
  
  after_filter :expire_cache, :only => [:update, :create, :destroy]

  # GET /salespeople
  # GET /salespeople.xml
  def index
    @salespeople = Salesperson.find(:all, :order => 'name asc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salespeople }
    end
  end

  # GET /salespeople/1
  # GET /salespeople/1.xml
  def show
    @salesperson = Salesperson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @salesperson }
    end
  end

  # GET /salespeople/new
  # GET /salespeople/new.xml
  def new
    @salesperson = Salesperson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @salesperson }
    end
  end

  # GET /salespeople/1/edit
  def edit
    @salesperson = Salesperson.find(params[:id])
  end

  # POST /salespeople
  # POST /salespeople.xml
  def create
    @salesperson = Salesperson.new(params[:salesperson])

    respond_to do |format|
      if @salesperson.save
        flash[:notice] = 'Salesperson was successfully created.'
        format.html { redirect_to( admin_salespeople_path ) }
        format.xml  { render :xml => @salesperson, :status => :created, :location => @salesperson }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @salesperson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salespeople/1
  # PUT /salespeople/1.xml
  def update
    @salesperson = Salesperson.find(params[:id])

    respond_to do |format|
      if @salesperson.update_attributes(params[:salesperson])
        flash[:notice] = 'Salesperson was successfully updated.'
        format.html { redirect_to( admin_salespeople_path ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @salesperson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salespeople/1
  # DELETE /salespeople/1.xml
  def destroy
    @salesperson = Salesperson.find(params[:id])
    @salesperson.destroy

    respond_to do |format|
      format.html { redirect_to(admin_salespeople_path) }
      format.xml  { head :ok }
    end
  end

private

  def expire_cache
    expire("contact")
  end
end
