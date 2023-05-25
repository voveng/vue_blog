module Comments
  class UpdateComment < ActiveInteraction::Base
    object :comment
    string :body, default: nil

    def execute
      comment.body = body

      errors.merge! comment.errors unless comment.save
      comment
    end
  end
end
