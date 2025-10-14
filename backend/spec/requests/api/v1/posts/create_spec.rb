# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/posts', type: :request do
  let(:user) { create :user }

  let(:valid_params) do
    {
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user_id: user.id
      }
    }
  end

  let(:invalid_params) do
    {
      post: {
        title: '',
        body: '',
        user_id: user.id
      }
    }
  end

  context 'with valid params' do
    before { post '/api/v1/posts', params: valid_params }

    it 'returns success status' do
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new post' do
      expect { post '/api/v1/posts', params: valid_params }
        .to change(Post, :count).by(1)
    end

    it 'returns the created post' do
      post '/api/v1/posts', params: valid_params
      response_body = JSON.parse(response.body)
      expect(response_body).to include(
        '_interaction_result' => hash_including(
          'title' => valid_params[:post][:title],
          'body' => valid_params[:post][:body],
          'user_id' => user.id
        )
      )
      # Check if ID is present in the result
      expect(response_body['_interaction_result']['id']).to be_present
    end
  end

  context 'with invalid params' do
    before { post '/api/v1/posts', params: invalid_params }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create a new post' do
      expect { post '/api/v1/posts', params: invalid_params }
        .not_to change(Post, :count)
    end

    it 'returns error messages' do
      expect(JSON.parse(response.body)).to include(
        'success' => false,
        'errors' => kind_of(Array)
      )
    end
  end
end