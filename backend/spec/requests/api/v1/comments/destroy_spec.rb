# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /api/v1/comments/:id', type: :request do
  let(:user) { create :user }
  let(:target_post) { create :post }
  let!(:comment) { create :comment, user: user, post: target_post }

  before { delete "/api/v1/posts/#{target_post.id}/comments/#{comment.id}" }

  it 'returns success status' do
    expect(response).to have_http_status(:ok)
  end

  it 'deletes the comment' do
    expect { delete "/api/v1/posts/#{target_post.id}/comments/#{comment.id}" }
      .to change(Comment, :count).by(-1)
  end

  it 'returns success response' do
    expect(JSON.parse(response.body)).to include('success' => true)
  end
end