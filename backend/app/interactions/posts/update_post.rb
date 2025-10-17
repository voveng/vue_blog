# frozen_string_literal: true

module Posts
  class UpdatePost < ActiveInteraction::Base
    object :post
    object :user
    string :title, :body, default: nil

    def execute
      unless PostPolicy.new(user, post).update?
        errors.add(:user, 'is not authorized to update this post')
        return
      end

      return if errors.messages.present?

      post.title = title if title.present?
      post.body = body if body.present?

      errors.merge! post.errors unless post.save
      post
    end
  end
end
