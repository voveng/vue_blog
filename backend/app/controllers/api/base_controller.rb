# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include Pundit::Authorization

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def render_errors(errors: [], status: :unprocessable_entity)
      render json: { success: false, errors: }, status:
    end

    def render_success(resource = nil, status: :ok)
      result = { success: true }
      result.merge!(resource) if resource
      render json: result, status:
    end

    def render_resource_errors(resource, status: :unprocessable_entity)
      result = resource.errors.attribute_names.map do |attr|
        { key: attr, messages: resource.errors.full_messages_for(attr) }
      end
      render_errors errors: result, status:
    end
  end
end
