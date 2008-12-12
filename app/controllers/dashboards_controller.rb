class DashboardsController < ApplicationController
  layout "admin"
  
  before_filter :login_required
    
  def show
    @registrations = Registration.find(:all, :order => "created_at ASC")
    
    
    respond_to do |format|
      format.html
    end
  end

end
