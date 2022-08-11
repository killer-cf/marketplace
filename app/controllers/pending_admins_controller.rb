class PendingAdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pending_admins = Admin.pending
  end

  def approve
    @admin = Admin.find(params[:id])
    @admin.approved!
    redirect_to pending_admins_path
  end

  def reject
    @admin = Admin.find(params[:id])
    @admin.rejected!
    redirect_to pending_admins_path
  end
end
