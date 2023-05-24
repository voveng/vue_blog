module Api
  module V1
    class CommentsController < Api::BaseController

      def create

      end

      def update

      end

      def destroy

      end

      private

      def comment_params
        params.require(:comment).permit(:body, :post_id)
      end
    end
  end
end
