# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/posts', type: :request do
  let!(:posts) { create_list :post, 3 }

  before { get '/api/v1/posts' }

  it 'returns success status' do
    expect(response).to have_http_status(:ok)
  end

  it 'returns all posts' do
    expect(JSON.parse(response.body)['posts'].length).to eq(3)
  end

  it 'includes pagination information' do
    response_body = JSON.parse(response.body)
    expect(response_body).to include('pagination')
    expect(response_body['pagination']).to include(
      'current_page',
      'total_pages',
      'total_count',
      'per_page',
      'next_page',
      'prev_page'
    )
  end

  context 'with user_id parameter' do
    let(:user) { create :user }
    let!(:user_posts) { create_list :post, 2, user: user }

    before { get "/api/v1/posts?user_id=#{user.id}" }

    it 'returns only posts by specific user' do
      body = JSON.parse(response.body)
      expect(body['posts'].length).to eq(2)
      expect(body['posts'].all? { |post_item| post_item['user_id'] == user.id }).to be true
    end
  end

  context 'with search parameter' do
    let!(:matching_post) { create :post, title: 'Ruby on Rails Tutorial' }

    before { get '/api/v1/posts?search=rails' }

    it 'returns posts matching search term' do
      body = JSON.parse(response.body)
      expect(body['posts'].any? { |post_item| post_item['id'] == matching_post.id }).to be true
    end
  end
end