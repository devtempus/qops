class Admin::AdminController < ApplicationController
  layout 'administaration'

  before_action :authenticate_user!
  before_action :check_permission!, unless: :devise_controller?
  before_action :tree_categories

  PER_PAGE = 10

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    flash[:error] = exception.message
    redirect_to root_path
  end


  def check_permission!
    unless current_user.admin? || current_user.moderator?
      flash[:error] = "Access denied! You do not have permmission for this page"
      redirect_to root_path
    end
  end
  private

  def tree_categories
    @tree_categories = Category.roots.publicated
  end
end

