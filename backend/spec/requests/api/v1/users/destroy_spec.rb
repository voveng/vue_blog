# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /api/v1/users/:id', type: :request do
  let(:current_user) { create :user }

  before do
    allow_any_instance_of(Api::AuthenticatedController).to receive(:current_user).and_return(current_user)
    allow_any_instance_of(Api::AuthenticatedController).to receive(:authorize).and_return(true)
  end

  before { delete "/api/v1/profile/destroy" }

  it 'returns success status' do
    expect(response).to have_http_status(:ok)
  end

  it 'deletes the user' do
    expect { 
      delete "/api/v1/profile/destroy"
    }.to change(User, :count).by(-1)
  end

  it 'returns success response' do
    expect(JSON.parse(response.body)).to include('success' => true)
  end
end

