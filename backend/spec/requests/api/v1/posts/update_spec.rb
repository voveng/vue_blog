# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /api/v1/posts/:id', type: :request do
  let(:user) { create :user }
  let(:target_post) { create :post, user: user }

  let(:valid_params) do
    {
      post: {
        title: 'Updated Title',
        body: 'Updated body content'
      }
    }
  end

  let(:invalid_params) do
    {
      post: {
        title: '',
        body: ''
      }
    }
  end

  context 'with valid params' do
    before { put_json "/api/v1/posts/#{target_post.id}", params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the post' do
      target_post.reload
      expect(target_post.title).to eq('Updated Title')
      expect(target_post.body).to eq('Updated body content')
    end

    it 'returns success response' do
      expect(JSON.parse(response.body)).to include('success' => true)
    end
  end

  context 'with invalid params' do
    before { put_json "/api/v1/posts/#{target_post.id}", params: invalid_params }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not update the post' do
      original_title = target_post.title
      put_json "/api/v1/posts/#{target_post.id}", params: invalid_params
      target_post.reload
      expect(target_post.title).to eq(original_title)
    end

    it 'returns error messages' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end