# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::AuthenticatedController
      skip_before_action :authorize, only: %i[create sign_in]
      skip_after_action :verify_authorized, only: %i[create sign_in show]

      def show
        render json: current_user
      end

      def create
        creation_subject = Users::CreateUser.run user_params
        return render_resource_errors creation_subject unless creation_subject.valid?

        sign_in_subject = CreateJwtToken.run user_params
        return render_resource_errors sign_in_subject, status: :unauthorized unless sign_in_subject.valid?

        user = creation_subject.result
        user_data = {
          id: user.id,
          name: user.name,
          email: user.email,
          password_digest: user.password_digest,
          created_at: user.created_at.to_datetime.rfc3339,
          updated_at: user.updated_at.to_datetime.rfc3339
        }
        render_success({ _interaction_result: user_data }, status: :created)
      rescue BCrypt::Errors::InvalidHash
        render_errors errors: [{ key: :password, messages: [ErrorMessages.inapropriate_password] }]
      end

      def sign_in
        subject = CreateJwtToken.run user_params
        return render_resource_errors subject, status: :unauthorized unless subject.valid?

        render_success({ token: subject.result })
      end

      def update
        subject = Users::UpdateUser.run user_params.merge(user: current_user)
        return render_resource_errors subject unless subject.valid?

        render_success
      end

      def destroy
        subject = Users::DestroyUser.run user: current_user
        return render_resource_errors subject unless subject.valid?

        render_success
      end

      private

      def encode_token(user)
        payload = { uid: user.id, exp: Rails.configuration.jwt_token_expire_time.from_now.to_i }
        JWT.encode payload, Rails.configuration.jwt_secret_key, 'HS256'
      end

      def user_params
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :current_password)
      end
    end
  end
end
