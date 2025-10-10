# frozen_string_literal: true

module Posts
  class CreatePost < ActiveInteraction::Base
    object :user
    string :title, :body
    validates :title, :body, presence: true

    def execute
      post = Post.new(title: title, body: body, user: user, user_partition: user.id % 16)

      errors.merge! post.errors unless post.save
      post
    end
  end
end
