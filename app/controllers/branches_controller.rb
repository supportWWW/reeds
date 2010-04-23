class BranchesController < ApplicationController
  
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
  
end
