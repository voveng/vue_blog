module Api
  module V1
    class PostsController < Api::BaseController
      before_action :set_post, only: %i[edit show update destroy]

      def index
        posts = Post.all
        render json: posts
      end

      def show
        render json: [post: @post, comments: @post.comments]
      end

      def edit
      end

      def create
        subject = Posts::CreatePost.run post_params
        return render_resource_errors subject unless subject.valid?

        render json: subject if subject.valid?
      end

      def update
        subject = Posts::UpdatePost.run post_params.merge(post: @post )
        return render_resource_errors subject unless subject.valid?

        render_success
      end

      def destroy
        Posts::DestroyPost.run post: @post

        render_success
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.fetch(:post, {}).permit(:id, :title, :body)
      end
    end
  end
end
