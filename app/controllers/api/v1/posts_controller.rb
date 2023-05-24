module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all
      end

      def show

      end

      def create
        
      end

      def update

      end

      def destroy

      end

      private

      def post_params
        params.fetch(:post, {}).permit(:id, :title, :body)
      end
    end
  end
end
