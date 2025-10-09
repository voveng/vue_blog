# frozen_string_literal: true

module Comments
  class DestroyComment < ActiveInteraction::Base
    object :comment

    def execute
      comment.destroy
    end
  end
end
