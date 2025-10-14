# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/posts/:post_id/comments', type: :request do
  let!(:user) { create :user }
  let!(:target_post) { create :post }

  let!(:valid_params) do
    {
      comment: {
        body: Faker::Lorem.paragraph
      },
      user_id: user.id
    }
  end

  let!(:invalid_params) do
    {
      comment: {
        body: ''
      },
      user_id: user.id
    }
  end

  context 'with valid params' do
    before { post_json "/api/v1/posts/#{target_post.id}/comments", params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new comment' do
      expect { post_json "/api/v1/posts/#{target_post.id}/comments", params: valid_params }
        .to change(Comment, :count).by(1)
    end

    it 'returns the post and comments' do
      post_json "/api/v1/posts/#{target_post.id}/comments", params: valid_params
      expect(JSON.parse(response.body)).to include(
        'post' => kind_of(Hash),
        'comments' => kind_of(Array)
      )
    end
  end

  context 'with invalid params' do
    before { post_json "/api/v1/posts/#{target_post.id}/comments", params: invalid_params }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create a new comment' do
      expect { post_json "/api/v1/posts/#{target_post.id}/comments", params: invalid_params }
        .not_to change(Comment, :count)
    end

    it 'returns error messages' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end
