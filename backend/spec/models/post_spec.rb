# frozen_string_literal: true

require 'rails_helper'
require 'posts/post_status'

RSpec.describe Post, type: :model do
  subject { build :post }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'status handling' do
    let(:post) { create(:post) }

    it 'defaults to draft' do
      expect(post.status).to eq(Posts::PostStatus.from_string(:draft))
      expect(post.status).to be_draft
    end

    it 'can be set with a Posts::PostStatus object' do
      post.status = Posts::PostStatus.from_string(:published)
      expect(post.status).to eq(Posts::PostStatus.from_string(:published))
      expect(post.status).to be_published
    end

    it 'can be set with a string' do
      post.status = 'published'
      expect(post.status).to eq(Posts::PostStatus.from_string(:published))
      expect(post.status).to be_published
    end

    it 'raises an error for invalid status string' do
      expect { post.status = 'invalid' }.to raise_error(ArgumentError, 'Invalid post status: invalid')
    end

    it 'publishes the post' do
      post.publish
      expect(post.status).to eq(Posts::PostStatus.from_string(:published))
      expect(post.status).to be_published
    end

    it 'unpublishes the post' do
      post.status = Posts::PostStatus.from_string(:published)
      post.unpublish
      expect(post.status).to eq(Posts::PostStatus.from_string(:draft))
      expect(post.status).to be_draft
    end
  end

  describe Posts::PostStatus do
    it 'can be created from a string' do
      expect(Posts::PostStatus.from_string('draft')).to eq(Posts::PostStatus.from_string(:draft))
      expect(Posts::PostStatus.from_string('published')).to eq(Posts::PostStatus.from_string(:published))
    end

    it 'raises error for invalid string' do
      expect { Posts::PostStatus.from_string('invalid') }.to raise_error(ArgumentError, 'Invalid post status: invalid')
    end

    it 'checks if draft' do
      expect(Posts::PostStatus.from_string(:draft)).to be_draft
      expect(Posts::PostStatus.from_string(:published)).not_to be_draft
    end

    it 'checks if published' do
      expect(Posts::PostStatus.from_string(:published)).to be_published
      expect(Posts::PostStatus.from_string(:draft)).not_to be_published
    end

    it 'converts to string' do
      expect(Posts::PostStatus.from_string(:draft).to_s).to eq('draft')
    end

    it 'compares correctly' do
      expect(Posts::PostStatus.from_string(:draft)).to eq(Posts::PostStatus.from_string(:draft))
      expect(Posts::PostStatus.from_string(:draft)).not_to eq(Posts::PostStatus.from_string(:published))
    end
  end
end

