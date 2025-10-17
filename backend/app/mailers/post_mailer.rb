# frozen_string_literal: true

class PostMailer < ApplicationMailer
  def post_published_email(post)
    @post = post
    @user = post.user

    mail(to: @user.email, subject: "Your post '#{@post.title}' has been published!")
  end
end
