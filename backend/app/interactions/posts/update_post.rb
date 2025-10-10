# frozen_string_literal: true

module Posts
  class UpdatePost < ActiveInteraction::Base
    object :post
    string :title, :body, default: nil

    def execute
      return if errors.messages.present?

      post.title = title if title.present?
      post.body = body if body.present?

      errors.merge! post.errors unless post.save
      post
    end
  end
end
