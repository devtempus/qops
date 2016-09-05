class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # after_filter :return_errors, only: [:page_not_found, :server_error]


  PER_PAGE = 10

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    flash[:error] = exception.message
    redirect_to root_path
  end


  # def page_not_found
  #   @status = 404
  #   @layout = "application"
  #   @template = "not_found_error"
  # end
  #
  # def server_error
  #   @status = 500
  #   @layout = "error"
  #   @template = "internal_server_error"
  # end

  private

  def return_errors
    respond_to do |format|
      format.html { render template: 'errors/' + @template, layout: 'layouts/' + @layout, status: @status }
      format.all  { render nothing: true, status: @status }
    end
  end

end
