# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/posts/:id', type: :request do
  let!(:target_post) { create :post }
  let!(:comments) { create_list :comment, 2, post: target_post }

  before { get "/api/v1/posts/#{target_post.id}" }

  it 'returns success status' do
    expect(response).to have_http_status(:ok)
  end

  it 'returns the post with comments' do
    body = JSON.parse(response.body)
    expect(body).to include('post')
    expect(body['post']).to include(
      'id' => target_post.id,
      'title' => target_post.title,
      'body' => target_post.body,
      'user_id' => target_post.user_id
    )
    expect(body).to include('comments')
    expect(body['comments'].length).to eq(2)
  end
end