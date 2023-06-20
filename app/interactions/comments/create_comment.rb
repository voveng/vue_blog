# frozen_string_literal: true

module Comments
  class CreateComment < ActiveInteraction::Base
    object :post, :user
    string :body, :user_id

    validates :body, presence: true

    def execute
      comment = post.comments.build inputs
      comment.user = user
      errors.merge! comment.errors unless comment.save
      comment
    end
  end
end
