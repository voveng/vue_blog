# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::BaseController
      before_action :set_post, only: %i[edit show update destroy]

      def index
        posts = Post.order(created_at: :desc)

        posts = posts.where(user_id: params[:user_id]) if params[:user_id].present?

        if params[:search].present?
          posts = posts.where('title ILIKE ? OR body ILIKE ?',
                              "%#{params[:search]}%",
                              "%#{params[:search]}%")
        end

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
