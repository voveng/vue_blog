# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::BaseController

      def show
        user = User.find(params[:id])
        render json: user
      end

      def create
        subject = Users::CreateUser.run user_params
        return render_resource_errors subject unless subject.valid?

        render json: subject, status: :created if subject.valid?
      rescue BCrypt::Errors::InvalidHash
        render_errors errors: [{ key: :password, messages: [ErrorMessages.inapropriate_password] }]
      end

      def sign_in
        subject = CreateJwtToken.run params
        return render_resource_errors subject, status: :unauthorized unless subject.valid?

        render_success({ token: subject.result })
      end

      def update
        user = User.find(params[:user][:id])

        subject = Users::UpdateUser.run user_params.merge(user:)
        return render_resource_errors subject unless subject.valid?

        render_success
      end

      private

      def user_params
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :current_password)
      end
    end
  end
end
