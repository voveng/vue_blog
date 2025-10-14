# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/sign_in', type: :request do
  let(:user) { create :user, password: 'password', password_confirmation: 'password' }

  let(:valid_params) do
    {
      user: {
        email: user.email,
        password: 'password'
      }
    }
  end

  let(:invalid_params) do
    {
      user: {
        email: user.email,
        password: 'wrong_password'
      }
    }
  end

  context 'with valid credentials' do
    before { post_json '/api/v1/sign_in', params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a token' do
      expect(JSON.parse(response.body)).to include(
        'success' => true,
        'token' => kind_of(String)
      )
    end
  end

  context 'with invalid credentials' do
    before { post_json '/api/v1/sign_in', params: invalid_params }

    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns error response' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end
