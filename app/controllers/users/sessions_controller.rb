class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    super
  end

  # def destroy
  #   super
  # end

  private

  def user_params
    accessible = [ :name, :email ]
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
