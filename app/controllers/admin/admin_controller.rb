class Admin::AdminController < ApplicationController
  before_action :authorize_admin

  def index
  end

  private

  def authorize_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
  
end