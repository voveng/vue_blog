module Api
  module V1
    class PostsController < Api::BaseController
      skip_before_action :verify_authenticity_token
      
      def index
        @posts = Post.all
      end

      def show

      end

      def create
        subject = Posts::CreatePost run post_params
        return resource_errors subject unless subject.valid?

        render json: subject if subject.valid?
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
