module Posts
  class DestroyPost < ActiveInteraction::Base
    object :post

    def execute
      debugger
      post.destroy
    end
  end
end
