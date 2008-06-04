class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  before_filter :login_required
  before_filter :admin_required, :only => [ :new, :create, :destroy ]
  before_filter :load_user, :only => [ :edit, :update, :destroy ]
  before_filter :owner_required, :only => [ :edit, :update ]
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      self.current_user = @user # !! now logged in
      flash[:notice] = "User successfully created"
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user.password = ''
    @user.password_confirmation = ''
  end
  
  def update
    if @user.update_attributes( params[:user] )
      flash[:notice] = "User successfully updated"
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  protected
  
  def load_user
    @user = User.find( params[:id] )
  end
  
  def owner_required
    ( current_user.id == @user.id || current_user.is_admin? ) || non_admin_access_denied
  end
  
end
