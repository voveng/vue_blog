module Posts
  class CreatePost < ActiveInteraction::Base
    string :title, :body
    validates :title, :body, presence: true

    def execute
      post = Post.new inputs

      errors.merge! post.errors unless post.save
      post
    end
  end
end
