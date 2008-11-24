class AccountsController < ApplicationController
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
end
