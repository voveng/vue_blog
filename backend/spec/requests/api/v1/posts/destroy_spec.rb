# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /api/v1/posts/:id', type: :request do
  let(:user) { create :user }
  let!(:target_post) { create :post, user: user }

  before { delete "/api/v1/posts/#{target_post.id}" }

  it 'returns success status' do
    expect(response).to have_http_status(:ok)
  end

  it 'deletes the post' do
    expect { delete "/api/v1/posts/#{target_post.id}" }
      .to change(Post, :count).by(-1)
  end

  it 'returns success response' do
    expect(JSON.parse(response.body)).to include('success' => true)
  end
end