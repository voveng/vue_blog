# frozen_string_literal: true

module Posts
  class DestroyPost < ActiveInteraction::Base
    object :post
    object :user

    def execute
      unless PostPolicy.new(user, post).destroy?
        errors.add(:user, 'is not authorized to destroy this post')
        return
      end

      post.destroy
    end
  end
end
