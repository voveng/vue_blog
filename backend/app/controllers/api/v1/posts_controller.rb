# frozen_string_literal: true

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

      def edit; end

      def create
        current_user = User.find(params[:post][:user_id])
        subject = Posts::CreatePost.run post_params.merge(user: current_user)
        return render_resource_errors subject unless subject.valid?

        render json: subject if subject.valid?
      end

      def update
        subject = Posts::UpdatePost.run post_params.merge(post: @post)
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
        params.fetch(:post, {}).permit(:id, :title, :body, :user_id)
      end
    end
  end
end
