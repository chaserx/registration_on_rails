class SessionsController < ApplicationController
  def new
  end
  
  def create
    account = Account.authenticate(params[:login], params[:password])
    if account
      session[:account_id] = account.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_url
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:account_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
