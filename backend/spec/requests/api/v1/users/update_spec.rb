# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /api/v1/users/:id', type: :request do
  let(:current_user) { create :user, name: 'Original Name', email: 'original@example.com' }

  let(:valid_params) do
    {
      user: {
        name: 'Updated Name',
        email: 'updated@example.com',
        current_password: 'password'  # Required for update
      }
    }
  end

  let(:invalid_params) do
    {
      user: {
        name: '',
        email: 'invalid_email',
        current_password: 'password'  # Required for update
      }
    }
  end

  before do
    allow_any_instance_of(Api::AuthenticatedController).to receive(:current_user).and_return(current_user)
    allow_any_instance_of(Api::AuthenticatedController).to receive(:authorize).and_return(true)
  end

  context 'with valid params' do
    before { put_json "/api/v1/profile/update", params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the user' do
      current_user.reload
      expect(current_user.name).to eq('Updated Name')
      expect(current_user.email).to eq('updated@example.com')
    end

    it 'returns success response' do
      expect(JSON.parse(response.body)).to include('success' => true)
    end
  end

  context 'with invalid params' do
    before { put_json "/api/v1/profile/update", params: invalid_params }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not update the user' do
      original_name = current_user.name
      put_json "/api/v1/profile/update", params: invalid_params
      current_user.reload
      expect(current_user.name).to eq(original_name)
    end

    it 'returns error messages' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end