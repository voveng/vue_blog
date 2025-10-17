# frozen_string_literal: true

module Posts
  class CreatePost < ActiveInteraction::Base
    object :user
    string :title, :body
    validates :title, :body, presence: true

    def execute
      post = Post.new(title: title, body: body, user: user, user_partition: user.id % 16)

      if post.save
        PostNotificationJob.perform_later(post.id)
      else
        errors.merge! post.errors
      end

      post
    end
  end
end
