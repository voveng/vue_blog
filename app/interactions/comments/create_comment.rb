module Comments
  class CreateComment < ActiveInteraction::Base
    object :post
    string :body

    validates :body, presence: true

    def execute
      comment = post.comments.build inputs

      errors.merge! comment.errors unless comment.save
      comment
    end
  end
end
