# frozen_string_literal: true

class PostNotificationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    PostMailer.post_published_email(post).deliver_now
  end
end
