# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /api/v1/comments/:id', type: :request do
  let(:user) { create :user }
  let(:target_post) { create :post }
  let!(:comment) { create :comment, user: user, post: target_post }

  let(:valid_params) do
    {
      comment: {
        body: 'Updated comment body'
      }
    }
  end

  let(:invalid_params) do
    {
      comment: {
        body: ''
      }
    }
  end

  context 'with valid params' do
    before { put_json "/api/v1/comments/#{comment.id}", params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the comment' do
      comment.reload
      expect(comment.body).to eq('Updated comment body')
    end

    it 'returns success response' do
      expect(JSON.parse(response.body)).to include('success' => true)
    end
  end

  context 'with invalid params' do
    before { put_json "/api/v1/comments/#{comment.id}", params: invalid_params }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not update the comment' do
      original_body = comment.body
      put_json "/api/v1/comments/#{comment.id}", params: invalid_params
      comment.reload
      expect(comment.body).to eq(original_body)
    end

    it 'returns error messages' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end