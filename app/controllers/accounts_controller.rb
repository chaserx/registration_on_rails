class AccountsController < ApplicationController
  layout "admin"
  
  before_filter :create_brain_buster, :only => [:new]
  before_filter :validate_brain_buster, :only => [:create]
  
  
  before_filter :login_required, :only => [:new, :create] unless Account.nil?

  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(params[:account])
    if @account.save
      session[:account_id] = @account.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def index
    accounts = Account.find(:all)
    if accounts.empty?
      redirect_to signup_url
    else
      redirect_to login_url
    end
  end
  
end
