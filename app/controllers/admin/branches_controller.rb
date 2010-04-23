class Admin::BranchesController < Admin::ApplicationController
  
  after_filter :expire_cache, :only => [:update, :create, :assign, :remove_assignment, :destroy]

  # GET /branches GET /branches.xml
  def index
    @branches = Branch.find(:all, :order => 'name asc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @branches }
    end
  end

  # GET /branches/1 GET /branches/1.xml
  def show
    @branch = Branch.find(params[:id], :include => :assignments)
    @salespeople = Salesperson.find_not_in_branch( @branch.id )
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @branch }
    end
  end

  # GET /branches/new GET /branches/new.xml
  def new
    @branch = Branch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @branch }
    end
  end

  # GET /branches/1/edit
  def edit
    @branch = Branch.find(params[:id])
  end

  # POST /branches POST /branches.xml
  def create
    @branch = Branch.new(params[:branch])

    respond_to do |format|
      if @branch.save
        flash[:notice] = 'Branch was successfully created.'
        format.html { redirect_to(admin_branch_path(@branch)) }
        format.xml  { render :xml => @branch, :status => :created, :location => @branch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @branch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /branches/1 PUT /branches/1.xml
  def update
    @branch = Branch.find(params[:id])

    respond_to do |format|
      if @branch.update_attributes(params[:branch])
        flash[:notice] = 'Branch was successfully updated.'
        format.html { redirect_to(admin_branch_path(@branch)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @branch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1 DELETE /branches/1.xml
  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy

    respond_to do |format|
      format.html { redirect_to(admin_branches_path) }
      format.xml  { head :ok }
    end
  end
  
  def assign
    @branch = Branch.find( params[:branch_id] )
    @salesperson = Salesperson.find( params[:id] )
    if @branch.assignments.find( :first, :conditions => { :salesperson_id => @salesperson.id } ).blank?
      @assignment = @branch.assignments.create( :salesperson_id => @salesperson.id )
      respond_to do |format|
        format.js
      end
    else
        render :nothing => true
    end
  end
  
  def remove_assignment
    @assignment = Assignment.find_by_branch_and_salesperson( params[:branch_id], params[:id] )
    if @assignment
      @branch = @assignment.branch
      @assignment.destroy
      @salespeople = Salesperson.find_not_in_branch( @assignment.branch_id )
      respond_to do |format|
        format.js
      end
    else
      head :ok
    end
  end
  
private

  def expire_cache
    expire("contact")
  end
end
