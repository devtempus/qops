module Api
  module V1
    class SessionsController < Api::V1::BaseController

      def create
        # user = User.find_for_database_authentication(email: sign_in_params[:email])
      end

      protected

      def sign_in_params
        params.require(:user).permit(:email, :password, :salt)
      end
    end
  end
end
