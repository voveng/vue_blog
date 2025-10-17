# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::AuthenticatedController
      include Pundit::Authorization

      skip_before_action :authorize, only: %i[index show]
      skip_after_action :verify_authorized, only: %i[index show]

      before_action :set_post, only: %i[edit show update destroy]

      def index
        posts = policy_scope(Post).recent

        posts = posts.where(user_id: params[:user_id]) if params[:user_id].present?
        posts = posts.search(params[:search]) if params[:search].present?

        page = params[:page] || 1
        per_page = [params[:per_page].to_i, 100].min
        per_page = 20 if per_page <= 0

        posts = posts.page(page).per(per_page)

        render json: {
          posts: posts,
          pagination: {
            current_page: posts.current_page,
            total_pages: posts.total_pages,
            total_count: posts.total_count,
            per_page: posts.limit_value,
            next_page: posts.next_page,
            prev_page: posts.prev_page
          }
        }
      end

      def show
        render json: [post: @post, comments: @post.comments]
      end

      def edit; end

      def create
        subject = Posts::CreatePost.run post_params.merge(user: current_user)
        return render_resource_errors subject unless subject.valid?

        render json: subject if subject.valid?
      end

      def update
        subject = Posts::UpdatePost.run post_params.merge(post: @post, user: current_user)
        return render_resource_errors subject unless subject.valid?

        render_success
      end

      def destroy
        Posts::DestroyPost.run(post: @post, user: current_user)

        render_success
      end

      private

      # This method provides a user object for Pundit's policy_scope.
      # It safely finds the user from the auth token if present, or returns nil for guests.
      # This prevents 'current_user' from raising an error on public pages.
      def pundit_user
        subject = CheckAuthorize.run header: request.headers['Authorization']
        return nil unless subject.valid?

        User.find_by(id: subject.result[:uid])
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.fetch(:post, {}).permit(:id, :title, :body, :user_id)
      end
    end
  end
end