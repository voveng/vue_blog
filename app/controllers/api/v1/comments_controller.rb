module Api
  module V1
    class CommentsController < Api::BaseController

      def create
        post = Post.find(params[:post_id])
        subject = Comments::CreateComment.run comment_params.merge(post: post)

        return render_resource_errors subject unless subject.valid?

        render json: [post: post, comments: post.comments] if subject.valid?
      end

      def update
        comment = Comment.find(params[:id])
        subject = Comments::UpdateComment.run comment_params.merge(comment: comment)

        return render_resource_errors subject unless subject.valid?

        render_success
      end

      def destroy
        comment =Comment.find(params[:id])
        Comments::DestroyComment.run comment:comment
        
        render_success
      end

      private

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
